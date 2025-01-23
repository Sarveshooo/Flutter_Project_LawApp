import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/select_page.dart';
import 'package:flutter_application_1/singup_Page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            "Login",
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
            onTap: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return SelectPage();
              }));
            },
            // onTap: () async {
            //   if (_emailTextEditingController.text.trim().isNotEmpty &&
            //       _passwordTextEditingController.text.trim().isNotEmpty) {
            //     try {
            //       UserCredential userCredential =
            //           await _firebaseAuth.signInWithEmailAndPassword(
            //         email: _emailTextEditingController.text,
            //         password: _passwordTextEditingController.text,
            //       );
            //       log("C2W : User logged in: ${userCredential.user!.email}");
            //       if (context.mounted) {
            //         Navigator.of(context).pushReplacement(
            //           MaterialPageRoute(
            //             builder: (context) => const HomeScreen(),
            //           ),
            //         );
            //       }
            //     } on FirebaseAuthException catch (error) {
            //       log("C2W : ERROR : ${error.code}");
            //       log("C2W : ERROR : ${error.message}");

            //       String errorMessage = 'An error occurred'; // Default message
            //       if (error.code == 'invalid-credential') {
            //         errorMessage = 'Invalid email or password';
            //       }
            //       if (error.code == 'The email address is badly formatted') {
            //         errorMessage = 'Please enter correct Email-Id';
            //       }
            //       if (context.mounted) {
            //         CustomSnackbar.showCustomSnackbar(
            //           message: errorMessage,
            //           context: context,
            //         );
            //       }
            //     }
            //   } else {
            //     CustomSnackbar.showCustomSnackbar(
            //       message: 'Please enter both email and password',
            //       context: context,
            //     );
            //   }
            // },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
              child: const Text(
                "Login",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const RegisterScreen();
                  },
                ),
              );
            },
            child: const Text(
              "Create new account? Register",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
