import 'package:dutask/models/task_model.dart';
import 'package:flutter/material.dart';

extension TaskStatusMapping on TaskStatus {
  bool? mapToTristate() {
    return switch (this) {
      TaskStatus.active => false,
      TaskStatus.started => null,
      TaskStatus.completed => true,
    };
  }

  IconData mapToIcon() {
    return switch (this) {
      TaskStatus.active => Icons.radio_button_unchecked,
      TaskStatus.started => Icons.autorenew,
      TaskStatus.completed => Icons.check,
    };
  }

  TaskStatus toggle() {
    return switch (this) {
      TaskStatus.active => TaskStatus.started,
      TaskStatus.started => TaskStatus.completed,
      TaskStatus.completed => TaskStatus.active,
    };
  }
}

extension TaskStatusMapping2 on TaskStatus? {
  String mapToText() {
    return switch (this) {
      null => 'All',
      TaskStatus.active => 'Active',
      TaskStatus.started => 'Started',
      TaskStatus.completed => 'Completed',
    };
  }
}

extension TaskStatusBoolToggling on bool? {
  bool? toggle() {
    return switch (this) {
      false => null,
      null => true,
      true => false,
    };
  }
}
