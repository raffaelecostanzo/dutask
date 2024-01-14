import 'package:dutask/utils/extensions.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum TaskStatus { active, started, completed }

class TaskModel {
  TaskModel({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
  }) : id = uuid.v4();

  TaskModel.forToggle(TaskModel task)
      : id = task.id,
        title = task.title,
        description = task.description,
        dueDate = task.dueDate,
        status = task.status.toggle();

  TaskModel.forUpdate(String taskId, TaskModel task)
      : id = taskId,
        title = task.title,
        description = task.description,
        dueDate = task.dueDate,
        status = task.status;

  TaskModel.forDuplication(TaskModel task)
      : id = uuid.v4(),
        title = task.title,
        description = task.description,
        dueDate = task.dueDate,
        status = task.status;

  final String id;
  final String title;
  final String? description;
  final DateTime dueDate;
  final TaskStatus status;
}
