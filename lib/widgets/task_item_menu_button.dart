import 'package:dutask/models/task_model.dart';
import 'package:dutask/providers/tasks_provider.dart';
import 'package:dutask/utils/extensions.dart';
import 'package:dutask/screens/task_form_screen.dart';
import 'package:dutask/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskItemMenuButton extends ConsumerWidget {
  const TaskItemMenuButton(
    this.task, {
    super.key,
  });

  final TaskModel task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<Operation>(
      onSelected: (Operation selectedOperation) {
        final taskNotifier = ref.read(tasksProvider.notifier);
        switch (selectedOperation) {
          case Operation.update:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskFormScreen(task: task),
              ),
            );
          case Operation.delete:
            taskNotifier.deleteTask(task.id);
            context.showSnackBarWithUndo(
                taskNotifier, 'Task deleted successfully');
          case Operation.duplicate:
            taskNotifier.createTask(task.copyWith(id: uuid.v4()));
            context.showSnackBarWithUndo(
                taskNotifier, 'Task duplicated successfully');
          default:
            null;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Operation>>[
        const PopupMenuItem<Operation>(
          value: Operation.update,
          child: Text('Edit'),
        ),
        const PopupMenuItem<Operation>(
          value: Operation.delete,
          child: Text('Delete'),
        ),
        const PopupMenuItem<Operation>(
          value: Operation.duplicate,
          child: Text('Duplicate'),
        ),
      ],
    );
  }
}
