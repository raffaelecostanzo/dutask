import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:dutask/widgets/task_item.dart';
import 'package:dutask/widgets/task_list_filter_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskList extends ConsumerWidget {
  TaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(filteredTasks);
    return Column(
      children: [
        TaskListFilterRow(),
        Expanded(
          child: tasks.isEmpty
              ? Center(
                  child: Text('There are no tasks at the moment.'),
                )
              : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) => TaskItem(tasks[index]),
                ),
        ),
      ],
    );
  }
}
