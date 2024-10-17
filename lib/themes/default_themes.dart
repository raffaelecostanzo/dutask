import 'package:flutter/material.dart';

final defaultLightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    shape: const RoundedRectangleBorder(),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.light,
  ),
);

final defaultDarkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    shape: const RoundedRectangleBorder(),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark,
  ),
);
