import 'package:dutask/models/task_model.dart';
import 'package:dutask/providers/tasks_provider.dart';
import 'package:dutask/screens/task_form_screen.dart';
import 'package:dutask/utils/constants.dart';
import 'package:dutask/extensions/task_status_extension.dart';
import 'package:dutask/widgets/task_item_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskItem extends ConsumerWidget {
  const TaskItem(this.task, {super.key});

  final TaskModel task;

  String _returnSubtitle() {
    final dueDate = task.dueDate;
    if (dueDate == null) return '';

    return kDateFormat.format(dueDate);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Checkbox(
        tristate: true,
        value: task.status.mapToTristate(),
        onChanged: (_) =>
            ref.read(tasksProvider.notifier).toggleTaskStatus(task.id),
      ),
      title: Text(
        softWrap: false,
        task.title,
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          decoration: task.status == TaskStatus.completed
              ? TextDecoration.lineThrough
              : null,
        ),
      ),
      subtitle: Text(_returnSubtitle()),
      trailing: TaskItemMenuButton(task),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskFormScreen(task: task),
        ),
      ),
    );
  }
}
