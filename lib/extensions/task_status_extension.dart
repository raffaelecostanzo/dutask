import 'package:dutask/models/task_model.dart';
import 'package:dutask/types/task_status_filter.dart';
import 'package:flutter/material.dart';

extension TaskStatusExtension on TaskStatus {
  bool? mapToTristate() {
    return switch (this) {
      TaskStatus.active => false,
      TaskStatus.started => null,
      TaskStatus.completed => true,
    };
  }

  String mapToText() {
    return switch (this) {
      TaskStatus.active => 'Active',
      TaskStatus.started => 'Started',
      TaskStatus.completed => 'Completed',
    };
  }

  IconData mapToIcon() {
    return switch (this) {
      TaskStatus.active => Icons.radio_button_unchecked,
      TaskStatus.started => Icons.autorenew,
      TaskStatus.completed => Icons.check,
    };
  }

  bool equalsToFilter(TaskStatusFilter taskStatusFilter) {
    if (taskStatusFilter == TaskStatusFilter.all) return true;
    return taskStatusFilter.name == name;
  }

  TaskStatus toggle() {
    return switch (this) {
      TaskStatus.active => TaskStatus.started,
      TaskStatus.started => TaskStatus.completed,
      TaskStatus.completed => TaskStatus.active,
    };
  }
}
