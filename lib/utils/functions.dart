import 'package:dutask/extensions/common_extensions.dart';
import 'package:flutter/material.dart';

String dynamicToString(dynamic object) {
  if (object is ThemeMode) {
    return object.mapToString();
  } else {
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
