import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    primary: Colors.grey.shade900,   // Dark gray for primary elements
    inversePrimary: Colors.grey.shade300, // Lighter gray for contrast
    onPrimary: Colors.white,         // Text/icons on primary
    secondary: Colors.grey.shade700, // Darker secondary color
    onSecondary: Colors.white,       // Text on secondary
    background: Colors.grey.shade900,        // Full black background
    onBackground: Colors.white,      // Text on background
    surface: Colors.black,   // Cards/Containers dark gray
    onSurface: Colors.white,         // Text/icons on surface
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.orbitron(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Color(0xFFFF6B00), // Keeping the orange color for consistency
    ),
    bodyLarge: GoogleFonts.roboto(
      fontSize: 16,
      color: Colors.white, // White text for contrast
    ),
    bodySmall: GoogleFonts.roboto(
      fontSize: 14,
      fontStyle: FontStyle.italic,
      color: Colors.grey.shade400, // Lighter gray for readability
    ),
  ),
);
