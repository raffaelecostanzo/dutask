import 'package:dutask/models/task_model.dart';
import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:dutask/providers/quick_filter_provider.dart';
import 'package:dutask/screens/task_form_screen.dart';
import 'package:dutask/widgets/filter_settings_drawer.dart';
import 'package:dutask/widgets/main_drawer.dart';
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

  void _updateFabVisibility() {
    if (!_scrollController.hasClients) return;

    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    final isScrollable = maxScrollExtent > 0;

    if (!isScrollable && !_isFloatingActionButtonVisible) {
      setState(() {
        _isFloatingActionButtonVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<List<TaskModel>>(filteredTasks, (previous, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateFabVisibility();
      });
    });
    final tasks = ref.watch(filteredTasks);
    final currentQuickFilter = ref.watch(selectedQuickFilter);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dutask'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.filter_list_outlined),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: 'Open quick filters settings',
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      endDrawer: FilterSettingsDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterChipsBar(
            selectedFilter: currentQuickFilter,
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
