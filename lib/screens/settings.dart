import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoder/authservice/authservice.dart';
import 'package:khoder/components/myappbar.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    return Scaffold(
      appBar: MyAppBar(title: "SETTINGS"),
      body: Column(
        children: [
          SizedBox(height: 30,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Material(

          elevation: 10,
          child: ListTile(
            onTap: (){
              authService.signOut();
            },
            title: Text("LogOut" , style: GoogleFonts.orbitron(
                fontSize: 20,
                color: Color(0xFFFF6B00)
            ),),
            trailing: Icon(Icons.logout, color:Color(0xFFFF6B00) ,),

            ),


          ),
        ),
        ],
      ),
    );
  }
}
