import 'package:flutter/material.dart';
import 'package:khoder/loginandsignup/login.dart';
import 'package:khoder/loginandsignup/register.dart';

class LoginOrRegister extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController userNameController;
  final BuildContext parentContext; // Parent context passed from the widget

  const LoginOrRegister({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.userNameController,
    required this.parentContext, // Parent context passed from the widget
  });

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: AnimatedCrossFade(
        duration: Duration(milliseconds: 500),
        firstChild: Login(
          emailController: widget.emailController,
          passwordController: widget.passwordController,
          onPressed: togglePages,
          parentContext: widget.parentContext, // Use widget.parentContext
        ),
        secondChild: Register(
          emailController: widget.emailController,
          passwordController: widget.passwordController,
          confirmPasswordController: widget.confirmPasswordController,
          userNameController: widget.userNameController,
          onPressed: togglePages,
          parentContext: widget.parentContext, // Use widget.parentContext
        ),
        crossFadeState: showLoginPage ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstCurve: Curves.easeInOut,
        secondCurve: Curves.easeInOut,
        sizeCurve: Curves.fastOutSlowIn,
      ),
    );
  }
}