import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person_2_outlined,
                color: Colors.orange[800],
              ),
              labelText: 'User Name',
              labelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.orange[800],
              ),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),

          const SizedBox(height: 10),

          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_open, color: Colors.orange[800]),
              labelText: 'Password',
              labelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.orange[800],
              ),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),

          const SizedBox(height: 10),

          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.orange),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
              ),
              child: Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
              ),
            ),
          ),
          TextButton(onPressed: () {}, child: Text('Forgot Password?')),
        ],
      ),
    );
  }
}
