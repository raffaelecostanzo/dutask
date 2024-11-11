import 'package:dutask/extensions/string_extension.dart';
import 'package:dutask/extensions/theme_mode_extension.dart';
import 'package:flutter/material.dart';

String dynamicToString(Object object) {
  if (object is ThemeMode) {
    return object.mapToText();
  } else {
    return '';
  }
}

String getIconName(String iconName) {
  return iconName.replaceAll('_', ' ').capitalize();
}
