import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();

  static const Color loginGradientStart = const Color(0xFFfbab66);
  static const Color loginGradientEnd = const Color(0xFFf7418c);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Color icon_home = const Color(0xFFFF420E);
  static const Color text_menu_home = const Color(0xFF021C1E);
  static const Color bg_menu_home = const Color(0xFF4CB5F5);
  static const double text_size_home = 14;
  static const double icon_size_home = 24;
  static const double text_size_profile = 14;
  static const double icon_size_profile = 24;
  static const String text_font_home = "WorkSansSemi";

}