import 'package:dutask/models/task_model.dart';
import 'package:dutask/providers/tasks_provider.dart';
import 'package:dutask/extensions/date_time_extension.dart';
import 'package:dutask/extensions/task_status_extension.dart';
import 'package:dutask/types/task_date_filter.dart';
import 'package:dutask/types/task_status_filter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskStatusFilterProvider = StateProvider((ref) => TaskStatusFilter.all);
final taskDateFilterProvider = StateProvider((ref) => TaskDateFilter.all);

final filteredTasksProvider = Provider<List<TaskModel>>((ref) {
  final statusFilter = ref.watch(taskStatusFilterProvider);
  final dateFilter = ref.watch(taskDateFilterProvider);
  final tasks = ref.watch(tasksProvider);

  return tasks
      .where((task) =>
          task.status.equalsToFilter(statusFilter) &&
          task.dueDate.equalsToFilter(dateFilter))
      .toList();
});
