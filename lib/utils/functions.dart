import 'package:dutask/extensions/string_extension.dart';
import 'package:dutask/extensions/theme_mode_extension.dart';
import 'package:flutter/material.dart';

String dynamicToString(Object object) {
  return object is ThemeMode ? object.mapToText() : '';
}

String getIconName(String iconName) {
  return iconName.replaceAll('_', ' ').capitalize();
}
