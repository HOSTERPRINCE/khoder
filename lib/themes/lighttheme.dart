import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


var lightTheme= ThemeData(
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    primary: Colors.grey,
    inversePrimary: Colors.grey.shade900,// Primary color (buttons, text, icons)
    onPrimary: Colors.white,    // Text on primary color
    secondary: Colors.grey.shade500, // Secondary accents (light gray)
    onSecondary: Colors.black,  // Text on secondary
    background: Colors.grey.shade200,   // App background
    onBackground: Colors.black, // Text on background
    surface: Colors.white,      // Card/Container background
    onSurface: Colors.black,    // Text/icons on surface
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.orbitron(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Color(0xFFFF6B00),
    ),
    bodyLarge: GoogleFonts.roboto(
      fontSize: 16,
      color: Colors.white,
    ),
    bodySmall: GoogleFonts.roboto(
      fontSize: 14,
      fontStyle: FontStyle.italic,
      color: Colors.grey,
    ),
  ),
);