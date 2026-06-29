import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
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

          const SizedBox(height: 20),

          TextField(
            obscureText: true,
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

          const SizedBox(height: 20),

          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.orange),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
              ),
              child: Text(
                "SIGN UP",
                style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
