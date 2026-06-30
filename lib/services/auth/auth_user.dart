import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

@immutable
class AuthUser {
  final bool isEmailVerified;

  // Constructor
  const AuthUser(this.isEmailVerified);
  // Factory Constructor
  factory AuthUser.fromFirebase(User user) => AuthUser(user.emailVerified);
}

// void function() {
//   final obj = AuthUser(true);
//   final obj2 = AuthUser.fromFirebase(user);
// }
