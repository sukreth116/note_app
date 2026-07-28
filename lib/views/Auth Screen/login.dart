import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/auth_exceptions.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/auth_services.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/bloc/auth_event.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/bloc/auth_state.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/dialogs/error_dialog.dart';
import 'package:flutter_tutorial_first_sample_project/utilities/dialogs/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  // CloseDialog? _closeDialogHandle;

  @override
  void initState() {
    // _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          
          if (state.exception is UserNotFountException) {
            await showErrorDialog(context, 'User not found');
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, 'Wrong user credentials');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication Error');
          } else if (state.exception is InvalidEmailException) {
            await showErrorDialog(context, 'Invalid Email');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Unable Login');
          } else if (state.exception is InvalidCredentialException) {
            await showErrorDialog(context, 'Invali Credentials');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('LOG IN', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: SafeArea(
          child: FutureBuilder(
            // if not wrtten this got an exception => FirebaseException ([core/no-app] No Firebase App '[DEFAULT]' has been created - call Firebase.initializeApp())
            future: AuthServices.firebase().initialize(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'WELCOME TO MY APP',
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                          ),
                        ),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(hintText: 'Enter email'),
                        ),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          autocorrect: false,
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            hintText: 'Enter password',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            context.read<AuthBloc>().add(
                              AuthEventLogIn(email, password),
                            );
                          },
                          child: Text('Login'),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              const AuthEventShouldRegister(),
                            );
                          },
                          child: Text('Not have an account? Register here'),
                        ),
                      ],
                    ),
                  );
                default:
                  return Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    context.read<AuthBloc>().add(AuthEventLogIn(email, password));
    // try {
    // await AuthServices.firebase().logIn(email: email, password: password);
    // final user = AuthServices.firebase().currentUser;
    // if (user?.isEmailVerified ?? false) {
    //   Navigator.of(
    //     context,
    //   ).pushNamedAndRemoveUntil(notesRoute, (route) => false);
    // } else {
    //   Navigator.of(
    //     context,
    //   ).pushNamedAndRemoveUntil(emailVerificationRoute, (route) => false);
    // }
    // } on InvalidCredentialException {
    //   await showErrorDialog(context, 'Invalid Credentials');
    // } on UserNotFountException {
    //   await showErrorDialog(context, 'User not found');
    // } on WrongPasswordAuthException {
    //   await showErrorDialog(context, 'Wrong Password');
    // } on GenericAuthException {
    //   await showErrorDialog(context, 'Authentication Error');
    // }
  }

  // Future<void> _initializeWithDelay() async {
  //   // await Future.delayed(Duration(seconds: 3)); // fake delay
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  //   final user = FirebaseAuth.instance.currentUser;
  //   print('print user if, active before login screen $user');
  // }

  // Now don't need this because initialize function defined in authservice

  @override
  void dispose() {
    // _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
