import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/auth_screen/login_form.dart';
import 'package:flutter_tutorial_first_sample_project/auth_screen/register_view.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Login & Register
      child: Container(
        // color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: TabBar(
                  labelColor: Colors.orange.shade800,
                  unselectedLabelColor: Colors.orange.shade200,
                  indicatorColor: Colors.orange.shade800,
                  tabs: const [
                    Tab(text: "Login"),
                    Tab(text: "Register"),
                  ],
                ),
              ),

              const SizedBox(height: 0),

              // Forms
              Container(
                // color: Colors.amber,
                height: 290,
                // color: Colors.amber,
                child: TabBarView(children: [LoginForm(), RegisterForm()]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
