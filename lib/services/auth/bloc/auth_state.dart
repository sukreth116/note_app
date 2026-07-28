import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_tutorial_first_sample_project/services/auth/auth_user.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingText;
  const AuthState({
    required this.isLoading,
    this.loadingText = 'Please wait a moment',
  });
}

// class AuthStateLoading extends AuthState {
//   const AuthStateLoading();
// }

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required super.isLoading});
}

class AuthStateRegistering extends AuthState {
  final Exception exception;
  const AuthStateRegistering({required this.exception, required super.isLoading});
}

class AuthStatLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStatLoggedIn({required this.user, required super.isLoading});
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification({required super.isLoading});
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  const AuthStateLoggedOut({required this.exception, required super.isLoading, super.loadingText});

  @override
  List<Object?> get props => [exception, isLoading];
}

// class AuthStateLogoutFailure extends AuthState {
//   final Exception exception;
//   const AuthStateLogoutFailure(this.exception);
// }
