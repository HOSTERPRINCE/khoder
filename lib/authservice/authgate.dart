import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khoder/screens/entrypage.dart';
import 'package:khoder/screens/homepage.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context , snapshot){
        if(snapshot.hasData){
          return EntryPage();
        }
        else{
          return HomePage();
        }
      }),
    );
  }
}
