import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoder/authservice/authservice.dart';
import 'package:khoder/components/my_button.dart';
import 'package:khoder/components/mytextfield.dart';
import 'package:khoder/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  final void Function()? onPressed;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final BuildContext parentContext; // Renamed to avoid confusion

  const Login({
    super.key,
    required this.emailController,
    required this.onPressed,
    required this.passwordController,
    required this.parentContext, // Renamed to avoid confusion
  });

  void login() async {
    final AuthService authService = AuthService();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("Email and password cannot be empty.", Colors.red);
      return;
    }

    if (!_isValidEmail(email)) {
      _showSnackBar("Please enter a valid email address.", Colors.orange);
      return;
    }

    if (password.length < 6) {
      _showSnackBar("Password must be at least 6 characters.", Colors.orange);
      return;
    }

    try {
      await authService.signInWithEmailPassword(email, password);
    } catch (e) {
      _showSnackBar(_getFriendlyErrorMessage(e.toString()), Colors.red);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(parentContext).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email);
  }

  String _getFriendlyErrorMessage(String error) {
    if (error.contains("user-not-found")) {
      return "No user found for this email. Please register first.";
    } else if (error.contains("wrong-password")) {
      return "Incorrect password. Please try again.";
    } else if (error.contains("invalid-email")) {
      return "The email address is invalid.";
    } else {
      return "An unexpected error occurred. Please try again later.";
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "LOGIN",
                          style: GoogleFonts.orbitron(
                            fontSize: 34,
                            color: Color(0xFFFF6B00),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(0, -0.5),
                          end: Offset(0, 0),
                        ).animate(animation),
                        child: child,
                      );
                    },
                    child: IconButton(
                      key: ValueKey<bool>(isDarkMode),
                      onPressed: () {
                        themeProvider.toggleTheme();
                      },
                      icon: Icon(
                        isDarkMode ? Icons.light_mode : Icons.dark_mode,
                        color: isDarkMode ? Colors.white : Colors.black,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            MyTextField(controller: emailController, obscure: false, label: "Email"),
            SizedBox(height: 20),
            MyTextField(controller: passwordController, obscure: true, label: "Password"),
            SizedBox(height: 40),
            MyButton(onTap: (){
              login();
              Navigator.of(context).pop();

            }, text: "Login"), // Fixed: Call the login function
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member?",
                  style: GoogleFonts.orbitron(
                    fontSize: 18,
                    color: Color(0xFFFF6B00),
                  ),
                ),
                TextButton(
                  onPressed: onPressed,
                  child: Text(
                    "Register",
                    style: GoogleFonts.orbitron(
                      fontSize: 18,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}