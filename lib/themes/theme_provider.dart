
import 'package:flutter/material.dart';
import 'dark_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'light_mode.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  ThemeProvider({required bool isDarkMode}){
    _themeData = isDarkMode ? darkMode : lightMode;
  }

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme()async {
    SharedPreferences preferences =  await SharedPreferences.getInstance();
    if(themeData == lightMode){
      themeData = darkMode;
      preferences.setBool("IsDarkTheme", true);
    }
    else{
      themeData = lightMode;
      preferences.setBool("IsDarkTheme", false);
    }
  }
}