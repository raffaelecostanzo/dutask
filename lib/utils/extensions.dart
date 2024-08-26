import 'package:dutask/models/task_model.dart';
import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:dutask/providers/tasks_provider.dart';
import 'package:dutask/utils/constants.dart';

import 'package:flutter/material.dart';

extension TaskStatusMapping on TaskStatus {
  bool? mapToTristate() {
    switch (this) {
      case TaskStatus.active:
        return false;
      case TaskStatus.started:
        return null;
      case TaskStatus.completed:
        return true;
    }
  }

  String mapToText() {
    switch (this) {
      case TaskStatus.active:
        return 'Active';
      case TaskStatus.started:
        return 'Started';
      case TaskStatus.completed:
        return 'Completed';
    }
  }

  bool equalsToFilter(TaskStatusFilter taskStatusFilter) {
    if (taskStatusFilter == TaskStatusFilter.all) return true;
    return taskStatusFilter.name == this.name;
  }

  TaskStatus toggle() {
    switch (this) {
      case TaskStatus.active:
        return TaskStatus.started;
      case TaskStatus.started:
        return TaskStatus.completed;
      case TaskStatus.completed:
        return TaskStatus.active;
    }
  }
}

extension BoolToggling on bool? {
  bool? toggle() {
    switch (this) {
      case false:
        return null;
      case null:
        return true;
      case true:
        return false;
    }
  }
}

extension ShowSnackBarWithUndo on BuildContext {
  void showSnackBarWithUndo(
      TasksNotifier taskNotifier, String snackBarMessage) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(snackBarMessage),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => taskNotifier.undo(),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (this.isEmpty) return '';
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

extension DateTimeMapping on DateTime? {
  bool equalsToFilter(TaskDateFilter taskDateFilter) {
    if (this == null) {
      return taskDateFilter == TaskDateFilter.all;
    }
    switch (taskDateFilter) {
      case TaskDateFilter.all:
        return true;
      case TaskDateFilter.yesterday:
        return DateUtils.dateOnly(this!) ==
            DateUtils.dateOnly(DateUtils.addDaysToDate(DateTime.now(), -1));
      case TaskDateFilter.today:
        return DateUtils.isSameDay(this, DateTime.now());
      case TaskDateFilter.tomorrow:
        return DateUtils.dateOnly(this!) ==
            DateUtils.dateOnly(DateUtils.addDaysToDate(DateTime.now(), 1));
    }
  }
}

extension TaskDateFilterMapping on TaskDateFilter {
  int mapToBottomNavigationBarIndex() {
    switch (this) {
      case TaskDateFilter.all:
        return 0;
      case TaskDateFilter.yesterday:
        return 1;
      case TaskDateFilter.today:
        return 2;
      case TaskDateFilter.tomorrow:
        return 3;
    }
  }
}

extension IntMapping on int {
  TaskDateFilter toDateFilter() {
    switch (this) {
      case 0:
        return TaskDateFilter.all;
      case 1:
        return TaskDateFilter.yesterday;
      case 2:
        return TaskDateFilter.today;
      case 3:
        return TaskDateFilter.tomorrow;
      default:
        return TaskDateFilter.all;
    }
  }
}

extension TaskStatusFilterMapping on TaskStatusFilter {
  String mapToText() {
    switch (this) {
      case TaskStatusFilter.all:
        return 'All';
      case TaskStatusFilter.active:
        return 'Active';
      case TaskStatusFilter.started:
        return 'Started';
      case TaskStatusFilter.completed:
        return 'Completed';
    }
  }
}

extension ThemeModeMapping on ThemeMode {
  String mapToString() {
    switch (this) {
      case ThemeMode.system:
        return 'System default';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }
}

extension DateFormatting on String {
  DateTime? getDateOrNull() {
    if (this.isEmpty) return null;
    try {
      return dateFormat.parse(this);
    } catch (_) {
      return null;
    }
  }
}
