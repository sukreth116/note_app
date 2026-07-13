import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

@immutable
class AuthUser {
  final String? email;
  final bool isEmailVerified;

  // Constructor
  const AuthUser({required this.isEmailVerified, required this.email});
  // Factory Constructor
  factory AuthUser.fromFirebase(User user) =>
      AuthUser(isEmailVerified: user.emailVerified, email: user.email);
}

// void function() { 
//   final obj = AuthUser(true);
//   final obj2 = AuthUser.fromFirebase(user);
// }