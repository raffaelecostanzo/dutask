import 'package:dutask/models/task_model.dart';

final defaultTasks = [
  TaskModel(
    title: 'Brush your teeth',
    description: null,
    dueDate: DateTime.now(),
    membershipLists: null,
    status: TaskStatus.active,
    id: uuid.v4(),
  ),
  TaskModel(
    title: 'Eat well',
    description: null,
    dueDate: DateTime.now(),
    membershipLists: null,
    status: TaskStatus.active,
    id: uuid.v4(),
  ),
  TaskModel(
    title: 'Be absurd',
    description: null,
    dueDate: null,
    membershipLists: null,
    status: TaskStatus.active,
    id: uuid.v4(),
  )
];
