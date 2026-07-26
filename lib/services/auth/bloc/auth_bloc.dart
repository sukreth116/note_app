import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/auth_provider.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/bloc/auth_event.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateLoading()) {
    // initialize event
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(null));
      } else if (!user.isEmailVerified) {
        // ! in frontof object mean not(is email not verified)
        emit(const AuthStateNeedsVerification());
      } else {
        emit(AuthStatLoggedIn(user));
      }
    });

    // log in
    on<AuthEventLogIn>((event, emit) async {
      
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(email: email, password: password);
        emit(AuthStatLoggedIn(user));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(e));
      }
    });

    // log out
    on<AuthEventLogOut>((event, emit) async {
      try {
        emit(AuthStateLoading());
        await provider.logOut();
        emit(const AuthStateLoggedOut(null));
      } on Exception catch (e) {
        emit(AuthStateLogoutFailure(e));
      }
    });
  }
}
