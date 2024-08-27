import 'package:dutask/models/task_model.dart';
import 'package:dutask/providers/tasks_provider.dart';
import 'package:dutask/utils/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TaskStatusFilter { all, started, active, completed }
enum TaskDateFilter { all, yesterday, today, tomorrow }

final taskStatusFilter = StateProvider((ref) => TaskStatusFilter.all);
final taskDateFilter = StateProvider((ref) => TaskDateFilter.all);

final filteredTasks = Provider<List<TaskModel>>((ref) {
  final statusFilter = ref.watch(taskStatusFilter);
  final dateFilter = ref.watch(taskDateFilter);
  final tasks = ref.watch(tasksProvider);

  return tasks
      .where((task) =>
          task.status.equalsToFilter(statusFilter) &&
          task.dueDate.equalsToFilter(dateFilter))
      .toList();
});
