import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/auth_provider.dart';
import 'package:flutter_tutorial_first_sample_project/services/bloc/auth_event.dart';
import 'package:flutter_tutorial_first_sample_project/services/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
    : super(const AuthStateUninitialized(isLoading: true)) {
    // forgot password
    on<AuthEventForgotPassword>((event, emit) async {
      emit(
        const AuthStateForgotPassword(
          isLoading: false,
          exception: null,
          hasSentEmail: false,
        ),
      );
      final email = event.email;
      if (email == null) {
        return;
      }
      emit(
        const AuthStateForgotPassword(
          isLoading: true,
          exception: null,
          hasSentEmail: false,
        ),
      );
      bool didSendEmail;
      Exception? exception;
      try {
        await provider.sendResetPassword(toEmail: email);
        didSendEmail = true;
        exception = null;
      } on Exception catch (e) {
        didSendEmail = false;
        exception = e;
      }
      emit(
        AuthStateForgotPassword(
          isLoading: false,
          exception: exception,
          hasSentEmail: didSendEmail,
        ),
      );
      emit(AuthStateLoggedOut(exception: null, isLoading: false));
    });

    //send email verification
    on<AuthEventSendEmailVerification>((event, emit) async {
      await provider.sendEmailVerification();
      emit(state);
    });

    // event to go register page
    on<AuthEventShouldRegister>((event, emit) {
      emit(const AuthStateRegistering(exception: null, isLoading: false));
    });

    // event that after press register button
    on<AuthEventRegister>((event, emit) async {
      final email = event.email;
      final password = event.password;
      try {
        emit(const AuthStateRegistering(exception: null, isLoading: true));
        await provider.createUser(email: email, password: password);
        await provider.sendEmailVerification();
        emit(const AuthStateNeedsVerification(isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateRegistering(exception: e, isLoading: false));
      }
    });

    // initialize event
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      } else if (!user.isEmailVerified) {
        // ! in frontof object mean not(is email not verified)
        emit(const AuthStateNeedsVerification(isLoading: false));
      } else {
        emit(AuthStatLoggedIn(user: user, isLoading: false));
      }
    });

    // log in
    on<AuthEventLogIn>((event, emit) async {
      emit(
        const AuthStateLoggedOut(
          exception: null,
          isLoading: true,
          loadingText: 'Please wait while I log you in',
        ),
      );
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(email: email, password: password);
        if (!user.isEmailVerified) {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
          emit(const AuthStateNeedsVerification(isLoading: false));
        } else {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
        }
        emit(AuthStatLoggedIn(user: user, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });

    on<AuthEventLogOut>((event, emit) async {
      try {
        await provider.logOut();
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });

    on<AuthEventShouldLogIn>((event, emit) async {
      emit(
        const AuthStateLoggedOut(
          exception: null,
          isLoading: true,
          loadingText: 'Opening login...',
        ),
      );

      await Future.delayed(const Duration(milliseconds: 500));

      emit(const AuthStateLoggedOut(exception: null, isLoading: false));
    });
  }
}
