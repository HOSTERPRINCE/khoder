import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Icon leading;
  final void Function()? onTap;
  const MyListTile({super.key, required this.title, required this.leading, required this.subtitle , required this.onTap});

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Material(
          elevation: 10,
          child: ListTile(
            onTap: onTap,
            title: Text(title , style: GoogleFonts.orbitron(
              fontSize: 20,
              color: Color(0xFFFF6B00)
            ),),
            subtitle: Text(subtitle,style: GoogleFonts.orbitron(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary
            ),
            ),
            leading: leading,


                ),
        ),
    );
  }
}
