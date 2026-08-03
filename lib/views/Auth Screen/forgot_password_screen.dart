import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial_first_sample_project/services/bloc/auth_bloc.dart';
import 'package:flutter_tutorial_first_sample_project/services/bloc/auth_event.dart';
import 'package:flutter_tutorial_first_sample_project/services/bloc/auth_state.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/dialogs/error_dialog.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/dialogs/show_reset_password_dialog.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _textController.clear();
          }
          if (state.exception != null) {
            await showErrorDialog(
              context,
              'We could not complete your request. Please make sure you are registered user. you can as a new user',
            );
          } else if (state.hasSentEmail) {
            _textController.clear();
            await showResetPasswordResetDialog(context);
            
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Reset Password')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'If you forgot your password, simply enter your email and enter the submit button',
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autofocus: true,
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Enter your email here...',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final email = _textController.text;
                  context.read<AuthBloc>().add(AuthEventForgotPassword(email));
                },
                child: Text('Send link'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthEventLogOut());
                },
                child: Text('Back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
