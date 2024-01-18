import 'package:dutask/models/task_model.dart';
import 'package:dutask/utils/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TasksNotifier extends Notifier<List<TaskModel>> {
  List<TaskModel> _fetchTasks() {
    return [
      TaskModel(
        id: uuid.v4(),
        title: 'Brush your teeth',
        description: null,
        dueDate: DateTime.now(),
        status: TaskStatus.active,
      ),
      TaskModel(
        id: uuid.v4(),
        title: 'Eat well',
        description: null,
        dueDate: DateTime.now(),
        status: TaskStatus.active,
      ),
      TaskModel(
        id: uuid.v4(),
        title: 'Be absurd',
        description: null,
        dueDate: DateTime.now(),
        status: TaskStatus.active,
      )
    ];
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

  void toggleStatusTask(String taskId) {
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
    state = [...state.where((task) => task.id != taskId).toList()];
  }

  void undo() {
    final localPreviousState = [...state];
    state = [...previousState];
    previousState = [...localPreviousState];
  }
}

final tasksProvider = NotifierProvider<TasksNotifier, List<TaskModel>>(
  TasksNotifier.new,
);
