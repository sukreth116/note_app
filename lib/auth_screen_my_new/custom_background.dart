import 'package:flutter/material.dart';
import 'package:flutter_tutorial_first_sample_project/auth_screen_my_new/auth_view.dart';
import 'package:flutter_tutorial_first_sample_project/auth_screen_my_new/login_form.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            // Background
            Container(width: double.infinity, color: Colors.white),

            // Small overlapping circle
            Positioned(
              top: -55, // adjust this
              right: 200, // adjust this
              child: Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  color: Colors.orange[800],
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Big circle (top-right)
            Positioned(
              top: -130,
              right: -100,
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned(
              bottom: -40,
              left: -30,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.orange[800],
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned(
              bottom: 115,
              left: 115,
              child: Container(
                width: 75,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Center(child: AuthScreen()),
          ],
        ),
      ),
    );
  }
}
