import 'package:flutter/material.dart';
import 'package:khoder/authservice/authservice.dart';
import 'package:khoder/screens/add.dart';
import 'package:khoder/screens/complierscreen.dart';
import 'package:khoder/screens/feed.dart';
import 'package:khoder/screens/notes.dart';
import 'package:khoder/screens/settings.dart';
import 'package:khoder/screens/suggestions.dart';
import 'package:khoder/screens/typingscreen.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  int currentIndex=0;
  final List<Widget> pages=[
    Feed(),
    Notes(),
    Add(),
    CompilerScreen(),
    Suggestions(),
    TypingSpeedTest(),
    Settings()
  ];
  final AuthService authService= AuthService();
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xFFFF6B00),  // Selected tab color
          unselectedItemColor: Colors.grey,  // Unselected tab color
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        currentIndex: currentIndex,
          onTap: (index){
          setState(() {
            currentIndex=index;
          });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notes),
              label: "Notes",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Add",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.code),
              label: "Compiler",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb),
              label: "Suggestions",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.keyboard),
              label: "WPS",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
      ]),
      body: pages[currentIndex],
    );
  }
}
