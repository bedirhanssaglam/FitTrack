import 'package:flutter/material.dart';

class ColorConstants {
  static ColorConstants? _instance;
  static ColorConstants get instance {
    _instance ??= ColorConstants._init();
    return _instance!;
  }

  ColorConstants._init();

  Color mainColor = Color(0xFF0F172A);
  Color lightPurple = Color(0xFFE0DDFF);
  Color black = Color(0xFF0F172A);
  Color lightBlack = Color(0xFF3A3A3C);
  Color silver = Color(0xFFB5B5B5);
}
