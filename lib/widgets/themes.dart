import 'package:flutter/material.dart';

class Themes {
  static Color primary = const Color(0xFF212F3D);
  static Color secondary = const Color(0xFF283747);
  static Color lightPrimary = const Color(0xFFE8F5E9);
  static Color red = const Color(0xFFEC7063);
  static Color blue = const Color(0xFF5499C7);

  static final light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
  );
}
