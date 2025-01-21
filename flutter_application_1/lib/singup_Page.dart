import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Register",
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _emailTextEditingController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              decoration: const InputDecoration(
                hintText: "Enter your email",
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _passwordTextEditingController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              obscureText: !_showPassword,
              decoration: InputDecoration(
                hintText: "Enter your password",
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                hintStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                  child: Icon(
                    _showPassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              if (_emailTextEditingController.text.trim().isNotEmpty &&
                  _passwordTextEditingController.text.trim().isNotEmpty) {
                try {
                  UserCredential userCredential =
                      await _firebaseAuth.createUserWithEmailAndPassword(
                    email: _emailTextEditingController.text.trim(),
                    password: _passwordTextEditingController.text.trim(),
                  );
                  log("User registered: ${userCredential.user!.email}");
                  CustomSnackbar.showCustomSnackbar(
                    message: "User Registered Successfully",
                    context: context,
                  );
                  Navigator.of(context).pop();
                } on FirebaseAuthException catch (error) {
                  log("FirebaseAuthException: ${error.message}");
                  CustomSnackbar.showCustomSnackbar(
                    message: error.message ?? 'An error occurred',
                    context: context,
                  );
                }
              } else {
                CustomSnackbar.showCustomSnackbar(
                  message: "Please enter valid fields",
                  context: context,
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
              child: const Text(
                "Register User",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class CustomSnackbar {
  static showCustomSnackbar({
    required String message,
    required BuildContext context,
    int durationInSeconds = 4,
    String actionLabel = '',
    VoidCallback? onActionPressed,
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      backgroundColor: Colors.white,
      duration: Duration(seconds: durationInSeconds),
      action: actionLabel.isNotEmpty
          ? SnackBarAction(
              label: actionLabel,
              onPressed: onActionPressed ?? () {},
            )
          : null,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
