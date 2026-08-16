import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial_first_sample_project/extensions/buildcontext/loc.dart';
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
              context.loc.forgot_password_view_generic_error,
            );
          } else if (state.hasSentEmail) {
            _textController.clear();
            await showResetPasswordResetDialog(context);
            
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.loc.forgot_password)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                context.loc.forgot_password_view_prompt,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autofocus: true,
                controller: _textController,
                decoration: InputDecoration(
                  hintText: context.loc.email_text_field_placeholder,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final email = _textController.text;
                  context.read<AuthBloc>().add(AuthEventForgotPassword(email));
                },
                child: Text(context.loc.forgot_password_view_send_me_link),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthEventLogOut());
                },
                child: Text(context.loc.forgot_password_view_back_to_login),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
