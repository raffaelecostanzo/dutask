import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final defaultLightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    shape: const RoundedRectangleBorder(),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ).surface,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ).surface,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.light,
  ),
);

final defaultDarkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    shape: const RoundedRectangleBorder(),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ).surface,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ).surface,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark,
  ),
);
