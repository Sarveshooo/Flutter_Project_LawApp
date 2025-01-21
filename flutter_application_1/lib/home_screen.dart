import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_Page.dart';
//import 'package:flutter_application_1/singup_Page.dart';  // Assuming your Signup page is in this file

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Login Successful!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),  // Navigate to Register Screen
                  ),
                );
              },
              child: const Text('Go to Register New User'),
            ),
          ],
        ),
      ),
    );
  }
}
