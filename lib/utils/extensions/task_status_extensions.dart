import 'package:dutask/models/task_model.dart';
import 'package:dutask/providers/filtered_tasks_provider.dart';

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

extension TaskStatusBoolToggling on bool? {
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
