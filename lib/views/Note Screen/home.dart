import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/bloc/auth_event.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/bloc/auth_state.dart';
import 'package:flutter_tutorial_first_sample_project/views/Auth%20Screen/email_verification.dart';
import 'package:flutter_tutorial_first_sample_project/views/Auth%20Screen/login.dart';
import 'package:flutter_tutorial_first_sample_project/views/Note%20Screen/my_notes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc,AuthState>(
      builder: (context, state) {
        if (state is AuthStatLoggedIn) {
          return const MyNotes();
        } else if (state is AuthStateNeedsVerification) {
          return const EmailVerification();
        } else if (state is AuthStateLoggedOut) {
          return const LoginScreen();
        } else {
          return Scaffold(body: CircularProgressIndicator());
        }
      },
    );
    // return FutureBuilder(
    //   future: AuthServices.firebase().initialize(),
    //   builder: (context, snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.done:
    //         // final user = AuthServices.firebase().currentUser;
    //         final user = AuthServices.firebase().currentUser;
    //         print('now have a user that is $user');
    //         if (user != null) {
    //           print(user);
    //           if (user.isEmailVerified) {
    //             return MyNotes();
    //             // print('email verified');
    //           } else {
    //             return EmailVerification();
    //             // Navigator.of(context).push(
    //             //   MaterialPageRoute(
    //             //     builder: (ctx) {
    //             //       return EmailVerification();
    //             //     },
    //             //   ),
    //             // );
    //           }
    //         } else {
    //           return LoginScreen();
    //         }
    //       // return Text('Done home reached');
    //       default:
    //         return Text('Loading please wait');
    //     }
    //   },
    // );
  }
}
