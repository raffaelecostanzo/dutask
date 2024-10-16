import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:dutask/providers/quick_filter_provider.dart';
import 'package:dutask/screens/task_form_screen.dart';
import 'package:dutask/widgets/filter_chips_bar.dart';
import 'package:dutask/widgets/filter_settings_drawer.dart';
import 'package:dutask/widgets/main_drawer.dart';
import 'package:dutask/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'list_form_screen.dart';

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(filteredTasks);
    final currentQuickFilter = ref.watch(selectedQuickFilter);

    return Scaffold(
      drawer: MainDrawer(),
      endDrawer: FilterSettingsDrawer(),
      appBar: AppBar(
        title: const Text('Dutask'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(64),
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: FilterChipsBar(
              selectedFilter: currentQuickFilter,
            ),
          ),
        ),
      ),
      body: tasks.isEmpty
          ? Center(
              child: Text('There are no tasks at the moment.'),
            )
          : ListView.builder(
              padding: EdgeInsets.only(bottom: 128),
              itemCount: tasks.length,
              itemBuilder: (_, index) => TaskItem(tasks[index])),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            tooltip: 'List',
            heroTag: 'list',
            child: Icon(Icons.list),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ListFormScreen(),
              ),
            ),
            backgroundColor:
                Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            tooltip: 'Task',
            heroTag: 'task',
            child: Icon(Icons.task),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TaskFormScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
