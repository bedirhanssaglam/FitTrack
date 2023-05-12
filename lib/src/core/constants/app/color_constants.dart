import 'package:flutter/material.dart';

class ColorConstants {
  static ColorConstants? _instance;
  static ColorConstants get instance {
    _instance ??= ColorConstants._init();
    return _instance!;
  }

  ColorConstants._init();

  Color mainColor = const Color(0xFF0F172A);
  Color lightPurple = const Color(0xFFE0DDFF);
  Color black = const Color(0xFF0F172A);
  Color lightBlack = const Color(0xFF3A3A3C);
  Color silver = const Color(0xFFB5B5B5);
}
