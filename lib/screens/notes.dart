import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoder/components/myappbar.dart';
import 'package:khoder/screens/flutternotes.dart';
import 'package:khoder/screens/javanotes.dart';
import 'package:khoder/screens/pythonnotes.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "NOTES"),
      body: Column(
        children: [
          SizedBox(height: 20,),
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> FlutterNotes()));
            },
            title: Text("Flutter" , style: GoogleFonts.orbitron(
              fontSize: 20 ,
              color: Color(0xFFFF6B00),
            ),),
            leading: Image.asset("lib/code.png"),
            subtitle: Text("Flutter is a framework used to develop cross platform applications.", style: GoogleFonts.orbitron(
              fontSize: 16,
              color: Theme.of(context).colorScheme.inversePrimary
            ),),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PythonNotes()));
            },
            title: Text("Python" , style: GoogleFonts.orbitron(
              fontSize: 20 ,
              color: Color(0xFFFF6B00),
            ),),
            leading: Image.asset("lib/python.png"),
            subtitle: Text("Python is a programming language which user friendly and easy to learn", style: GoogleFonts.orbitron(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary
            ),),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> JavaNotes()));
            },
            title: Text("java" , style: GoogleFonts.orbitron(
              fontSize: 20 ,
              color: Color(0xFFFF6B00),
            ),),
            leading: Image.asset("lib/java.png"),
            subtitle: Text("java is a strictly typed object oriented language", style: GoogleFonts.orbitron(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary
            ),),
          ),
        ],
      ),
    );
  }
}
