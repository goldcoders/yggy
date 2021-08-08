import 'package:flutter/material.dart' show Brightness, ThemeData;

import '../../utils/appcolors.dart';
import '../../utils/constants.dart';

class AppTheme {
  final lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: appColors[PRIMARY],
    backgroundColor: appColors[BG_COLOR],
    buttonColor: appColors[SECONDARY],
    accentColor: appColors[ACCENT],
  );

  final darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: appColors[PRIMARY_DARK],
    backgroundColor: appColors[BG_COLOR_DARK],
    buttonColor: appColors[SECONDARY_DARK],
    accentColor: appColors[ACCENT_DARK],
  );
}
