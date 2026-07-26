import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_tutorial_first_sample_project/services/auth/auth_user.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStatLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStatLoggedIn(this.user);
}



class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification();
}

class AuthStateLoggedOut extends AuthState {
  final Exception? exception;
  const AuthStateLoggedOut(this.exception);
}

class AuthStateLogoutFailure extends AuthState {
  final Exception exception;
  const AuthStateLogoutFailure(this.exception);
}
