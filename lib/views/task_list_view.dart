import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:dutask/views/settings_view.dart';
import 'package:dutask/views/task_form_view.dart';
import 'package:dutask/widgets/bottom_date_nav_bar.dart';
import 'package:dutask/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:dutask/widgets/task_list_filter_row.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskListView extends ConsumerStatefulWidget {
  const TaskListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskListViewState();
}

class _TaskListViewState extends ConsumerState<TaskListView> {
  final _scrollController = ScrollController();
  bool _isFABVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels > 0) {
          if (_isFABVisible) {
            setState(() {
              _isFABVisible = false;
            });
          }
        }
      } else {
        if (!_isFABVisible) {
          setState(() {
            _isFABVisible = true;
          });
        }
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
            icon: const Icon(Icons.settings),
            tooltip: 'Go to settings page',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsView(),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          TaskListFilterRow(),
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
      bottomNavigationBar: BottomDayNavBar(),
      floatingActionButton: Visibility(
        visible: _isFABVisible,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskFormView(),
            ),
          ),
        ),
      ),
    );
  }
}
