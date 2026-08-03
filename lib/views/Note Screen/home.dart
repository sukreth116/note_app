import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial_first_sample_project/helpers/loading/loading_screen.dart';
import 'package:flutter_tutorial_first_sample_project/services/bloc/auth_bloc.dart';
import 'package:flutter_tutorial_first_sample_project/services/bloc/auth_event.dart';
import 'package:flutter_tutorial_first_sample_project/services/bloc/auth_state.dart';
import 'package:flutter_tutorial_first_sample_project/views/Auth%20Screen/email_verification.dart';
import 'package:flutter_tutorial_first_sample_project/views/Auth%20Screen/forgot_password_screen.dart';
import 'package:flutter_tutorial_first_sample_project/views/Auth%20Screen/login.dart';
import 'package:flutter_tutorial_first_sample_project/views/Auth%20Screen/register.dart';
import 'package:flutter_tutorial_first_sample_project/views/Note%20Screen/my_notes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStatLoggedIn) {
          return const MyNotes();
        } else if (state is AuthStateNeedsVerification) {
          return const EmailVerification();
        } else if (state is AuthStateLoggedOut) {
          return const LoginScreen();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordScreen();
        } else if (state is AuthStateRegistering) {
          return const RegisterScreen();
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
