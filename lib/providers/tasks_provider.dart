import 'package:dutask/data/initial_tasks.dart';
import 'package:dutask/models/task_model.dart';
import 'package:dutask/extensions/task_status_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TasksProvider extends Notifier<List<TaskModel>> {
  List<TaskModel> _fetchTasks() {
    return initialTasks;
  }

  @override
  List<TaskModel> build() {
    return _fetchTasks();
  }

  late List<TaskModel> previousState;

  void createTask(TaskModel task) {
    previousState = [...state];
    state = [...state, task];
  }

  void toggleTaskStatus(String taskId) {
    previousState = [...state];
    final localPreviousState = [...state];
    final taskToReplaceIndex = state.indexWhere((task) => task.id == taskId);
    localPreviousState[taskToReplaceIndex] = state[taskToReplaceIndex]
        .copyWith(status: state[taskToReplaceIndex].status.toggle());
    state = [...localPreviousState];
  }

  void updateTask(String taskId, TaskModel updatedTask) {
    previousState = [...state];
    final localPreviousState = [...state];
    final taskToReplaceIndex = state.indexWhere((task) => task.id == taskId);
    localPreviousState[taskToReplaceIndex] = updatedTask;
    state = [...localPreviousState];
  }

  void deleteTask(String taskId) {
    previousState = [...state];
    state = [...state.where((task) => task.id != taskId)];
  }

  void undo() {
    final localPreviousState = [...state];
    state = [...previousState];
    previousState = [...localPreviousState];
  }
}

final tasksProvider = NotifierProvider<TasksProvider, List<TaskModel>>(
  TasksProvider.new,
);
