import 'package:dutask/utils/extensions/common_extensions.dart';
import 'package:flutter/material.dart';

String dynamicToString(dynamic object) {
  switch (object.runtimeType) {
    case ThemeMode:
      return (object as ThemeMode).mapToString();
    default:
      return '';
  }
}

String getTaskFilterName(Type type) {
  final typeName = type.toString();
  switch (typeName) {
    case 'TaskStatusFilter':
      return 'Status';
    case 'TaskDateFilter':
      return 'Date';
    default:
      return 'Invalid filter';
  }
}

String getIconName(String iconName) {
  return iconName.replaceAll('_', ' ').capitalize();
}
