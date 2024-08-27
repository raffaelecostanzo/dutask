import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:dutask/utils/extensions.dart';
import 'package:dutask/screens/task_form_screen.dart';
import 'package:dutask/widgets/filter_navigation_bar.dart';
import 'package:dutask/widgets/app_drawer.dart';
import 'package:dutask/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:dutask/widgets/filter_chips_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskListViewState();
}

class _TaskListViewState extends ConsumerState<TaskListScreen> {
  final _scrollController = ScrollController();
  bool _isFloatingActionButtonVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final isAtEdge = _scrollController.position.atEdge;
      final isAtBottom = _scrollController.position.pixels > 0;

      if (isAtEdge && isAtBottom && _isFloatingActionButtonVisible) {
        setState(() {
          _isFloatingActionButtonVisible = false;
        });
      } else if (!isAtEdge && !_isFloatingActionButtonVisible) {
        setState(() {
          _isFloatingActionButtonVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(filteredTasks);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dutask'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_outlined),
            onPressed: () => null,
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterChipsBar<TaskStatusFilter>.FilterChipsBar(
            selectedFilterProvider: taskStatusFilter,
            filters: TaskStatusFilter.values,
            filterToText: (filter) => filter.mapToText(),
          ),
          Expanded(
            child: tasks.isEmpty
                ? Center(
                    child: Text('There are no tasks at the moment.'),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: tasks.length,
                    itemBuilder: (context, index) => TaskItem(tasks[index]),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: FilterNavigationBar(),
      floatingActionButton: Visibility(
        visible: _isFloatingActionButtonVisible,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskFormScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
