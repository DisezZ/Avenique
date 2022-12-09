import 'package:flutter/material.dart';

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

class CustomColorScheme {
  // Define colors use for light scheme
  static const primaryLight = Color(0xFF16558F);
  static const secondaryLight = Color(0xFF323348);
  static const backgroundLight = Color(0xFFFFFFFF);
  static const surfaceLight = Color(0xFFFEFFFF);

  // Define color use for dark scheme
  static const primaryDark = Color(0xFF66A3FF);
  static const secondaryDark = Color(0xFFFF66EF);
  static const backgroundDark = Color(0xFF000000);
  static const surfaceDark = Color(0xFF212831);

  // Define light color scheme
  static const lightScheme = ColorScheme(
      brightness: Brightness.light,
      primary: primaryLight,
      onPrimary: backgroundLight,
      secondary: secondaryLight,
      onSecondary: backgroundLight,
      error: Colors.redAccent,
      onError: Colors.black,
      background: backgroundLight,
      onBackground: secondaryLight,
      surface: surfaceLight,
      onSurface: secondaryLight);

  // Define dark color scheme
  static const darkScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: primaryDark,
      onPrimary: backgroundDark,
      secondary: secondaryDark,
      onSecondary: backgroundDark,
      error: Colors.redAccent,
      onError: Colors.black,
      background: backgroundDark,
      onBackground: primaryDark,
      surface: surfaceDark,
      onSurface: primaryDark);
}
