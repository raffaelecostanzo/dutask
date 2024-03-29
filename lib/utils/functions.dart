import 'package:dutask/utils/extensions.dart';
import 'package:flutter/material.dart';

String dynamicToString(dynamic object) {
  switch (object.runtimeType) {
    case ThemeMode:
      return (object as ThemeMode).mapToString();
    default:
      return '';
  }
}
