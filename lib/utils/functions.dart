import 'package:dutask/extensions/common_extensions.dart';
import 'package:flutter/material.dart';

String dynamicToString(dynamic object) {
  if (object is ThemeMode) {
    return object.mapToText();
  } else {
    return '';
  }
}

String getIconName(String iconName) {
  return iconName.replaceAll('_', ' ').capitalize();
}
