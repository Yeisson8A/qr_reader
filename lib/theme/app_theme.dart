import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.teal;
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    // Color primario
    primaryColor: primary,
    // Tema del AppBar
    appBarTheme: const AppBarTheme(
      color: primary, 
      elevation: 0, 
      centerTitle: true, 
      titleTextStyle: TextStyle(fontSize: 20, color: Colors.white)
    ),
    // Tema del FloatingActionButton
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      elevation: 0
    ),
    // Tema del BottomNavigationBar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primary,
      elevation: 0
    )
  );
}