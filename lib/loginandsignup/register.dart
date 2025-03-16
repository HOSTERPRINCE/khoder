
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoder/authservice/authservice.dart';
import 'package:khoder/components/my_button.dart';
import 'package:khoder/components/mytextfield.dart';
import 'package:khoder/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  final void Function()? onPressed;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController userNameController;
  final BuildContext parentContext;

  const Register({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.userNameController,
    required this.onPressed,
    required this.parentContext,
  });
  void register() async {
    final AuthService auth = AuthService();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String userName = userNameController.text.trim(); // Fixed: Use userNameController

    if (email.isEmpty || password.isEmpty || userName.isEmpty) {
      _showSnackBar("All fields are required.", Colors.red);
      return;
    }

    if (!_isValidEmail(email)) {
      _showSnackBar("Please enter a valid email address.", Colors.orange);
      return;
    }

    if (password.length < 6) {
      _showSnackBar("Password must be at least 6 characters long.", Colors.orange);
      return;
    }

    if (password != confirmPasswordController.text.trim()) {
      _showSnackBar("Passwords do not match.", Colors.red);
      return;
    }

    try {
      await auth.signUpWithEmailPassword(email, password, userName);
      _showSnackBar("Account created successfully!", Colors.green);
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
    if (error.contains("email-already-in-use")) {
      return "This email is already in use. Try logging in.";
    } else if (error.contains("invalid-email")) {
      return "The email address is invalid.";
    } else if (error.contains("weak-password")) {
      return "Your password is too weak. Try a stronger one.";
    } else {
      return "An unexpected error occurred. Please try again.";
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
                          "REGISTER",
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
            MyTextField(controller: userNameController, obscure: false, label: "Username"),
            SizedBox(height: 20),
            MyTextField(controller: passwordController, obscure: true, label: "Password"),
            SizedBox(height: 20),
            MyTextField(controller: confirmPasswordController, obscure: true, label: "Confirm Password"),
            SizedBox(height: 35),
            MyButton(onTap: (){
              register();
              Navigator.of(context).pop();
            }, text: "Register"), // Fixed: Call the register function
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already a member?",
                  style: GoogleFonts.orbitron(
                    fontSize: 18,
                    color: Color(0xFFFF6B00),
                  ),
                ),
                TextButton(
                  onPressed: onPressed,
                  child: Text(
                    "Login",
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