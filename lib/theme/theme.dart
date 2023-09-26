import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDark => themeMode == ThemeMode.dark;

  void toggleTheme(bool ison) {
    themeMode = ison ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class themeShifter {
  static final darktheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xffDADEEC),
      bottomAppBarTheme: BottomAppBarTheme(
        color: Colors.white,
      ),
      colorScheme: ColorScheme.light(),
      iconTheme: IconThemeData(color: Colors.white));

  static final lighttheme = ThemeData(
      scaffoldBackgroundColor: Color.fromRGBO(51, 51, 51, 1),
      colorScheme: ColorScheme.dark(),
      bottomAppBarTheme: BottomAppBarTheme(color: Colors.white),
      iconTheme: IconThemeData(color: Colors.black));
}
