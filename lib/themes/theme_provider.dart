import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khoder/themes/darkTheme.dart';
import 'package:khoder/themes/lighttheme.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightTheme;

  ThemeData get themeData =>  _themeData;
  bool get isDarkMode =>_themeData==darkTheme;

  set themeData(ThemeData themeData){
    _themeData=themeData;
    notifyListeners();
  }

  void toggleTheme(){
    if(_themeData==lightTheme){
      themeData=darkTheme;
    }
    else{
      themeData=lightTheme;
    }
  }
}