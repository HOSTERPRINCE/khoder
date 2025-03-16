import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoder/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {  // ✅ Implements PreferredSizeWidget
  final String title;

  const MyAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.orbitron(fontSize: 20, color: Color(0xFFFF6B00)),
      ),
      actions: [
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
              size: 30,  // ✅ Reduced size to 30 (50 was too large for an AppBar)
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // ✅ Required override
}
