import 'package:dutask/models/task_model.dart';
import 'package:dutask/providers/tasks_provider.dart';
import 'package:dutask/utils/extensions/common_extensions.dart';
import 'package:dutask/screens/task_form_screen.dart';
import 'package:dutask/utils/extensions/task_status_extensions.dart';
import 'package:dutask/widgets/task_item_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dutask/utils/constants.dart';

enum Operation { create, read, update, delete, duplicate }

class TaskItem extends ConsumerWidget {
  const TaskItem(this.task, {super.key});

  final TaskModel task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      background: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [SizedBox(width: 24), Icon(Icons.delete)],
        ),
      ),
      secondaryBackground: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Icon(Icons.delete), SizedBox(width: 24)],
        ),
      ),
      key: ValueKey(task.id),
      onDismissed: (_) {
        final taskNotifier = ref.read(tasksProvider.notifier);
        taskNotifier.deleteTask(task.id);
        context.showSnackBarWithUndo(
            taskNotifier.undo, 'Task deleted successfully');
      },
      child: ListTile(
        leading: Checkbox(
          tristate: true,
          value: task.status.mapToTristate(),
          onChanged: (_) =>
              ref.read(tasksProvider.notifier).toggleStatusTask(task.id),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.status == TaskStatus.completed
                ? TextDecoration.lineThrough
                : null,
          ),
        ),
        subtitle: task.dueDate != null
            ? Text(dateFormat.format(task.dueDate!))
            : null,
        trailing: TaskItemMenuButton(task),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskFormScreen(task: task),
          ),
        ),
      ),
    );
  }
}
