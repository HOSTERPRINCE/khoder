import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const MyButton({super.key ,required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(12),
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Color(0xFFFF6B00), width: 3), // Orange outline
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Spacing
        ),
        child: Text(
          text,
          style: GoogleFonts.orbitron(
            fontSize: 20,
            color: Color(0xFFFF6B00), // Orange text color
          ),
        ),
      ),
    );
  }
}
