import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khoder/authservice/authgate.dart';
import 'package:khoder/firebase_options.dart';
import 'package:khoder/themes/darkTheme.dart';
import 'package:khoder/themes/lighttheme.dart';
import 'package:khoder/themes/theme_provider.dart';
import 'package:provider/provider.dart';

import 'screens/homepage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
      ChangeNotifierProvider(create: (context)=>ThemeProvider(),child: MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
