import 'package:dutask/models/task_model.dart';
import 'package:dutask/providers/tasks_provider.dart';
import 'package:dutask/utils/extensions.dart';
import 'package:dutask/views/task_form_view.dart';
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
        context.showSnackBarWithUndo(taskNotifier, 'Task deleted successfully');
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
        subtitle: Text(dateFormat.format(task.dueDate)),
        trailing: TaskItemMenuButton(task),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskFormView(task: task),
          ),
        ),
      ),
    );
  }
}
