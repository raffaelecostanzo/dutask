import 'package:dutask/models/task_model.dart';
import 'package:dutask/providers/tasks_provider.dart';
import 'package:dutask/extensions/task_date_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TaskDateFilter { yesterday, today, tomorrow }

final taskStatusFilter = StateProvider<TaskStatus?>((ref) => null);
final taskDateFilter = StateProvider<TaskDateFilter?>((ref) => null);

final filteredTasks = Provider<List<TaskModel>>((ref) {
  final statusFilter = ref.watch(taskStatusFilter);
  final dateFilter = ref.watch(taskDateFilter);
  final tasks = ref.watch(tasksProvider);

  return tasks
      .where((task) =>
          (statusFilter == null || task.status == statusFilter) &&
          (dateFilter == null || task.dueDate.equalsToFilter(dateFilter)))
      .toList();
});
