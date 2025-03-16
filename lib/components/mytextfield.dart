import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;
  final String label;
  const MyTextField({super.key, required this.controller, required this.obscure, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(12),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(

            hintText: label,
            hintStyle: GoogleFonts.orbitron(
              color: Color(0xFFFF6B00)
            ),
            enabledBorder: OutlineInputBorder(  // Normal border
              borderRadius: BorderRadius.circular(12), // Rounded corners
              borderSide: BorderSide(
                color: Color(0xFFFF6B00),  // Border color
                width: 3,  // Border width
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Color(0xFFFF6B00),
                width: 3,
              ),
            ),
          ),
          style: GoogleFonts.orbitron(color: Color(0xFFFF6B00)), // Text color inside TextField
          cursorColor: Color(0xFFFF6B00), // Cursor color
        ),
      ),
    );

  }
}
