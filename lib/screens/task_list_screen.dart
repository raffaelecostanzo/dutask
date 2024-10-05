import 'package:dutask/models/task_model.dart';
import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:dutask/providers/quick_filter_provider.dart';
import 'package:dutask/screens/list_form_screen.dart';
import 'package:dutask/screens/task_form_screen.dart';
import 'package:dutask/widgets/expandable_fab.dart';
import 'package:dutask/widgets/filter_chips_bar.dart';
import 'package:dutask/widgets/filter_settings_drawer.dart';
import 'package:dutask/widgets/main_drawer.dart';
import 'package:dutask/widgets/task_item.dart';
import 'package:flutter/material.dart';
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
      _updateFabVisibility();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _updateFabVisibility() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isScrollable = _scrollController.hasClients &&
          _scrollController.position.maxScrollExtent > 0;
      final isAtBottom = _scrollController.hasClients &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent;

      if (!isScrollable || !isAtBottom) {
        if (!_isFloatingActionButtonVisible) {
          setState(() {
            _isFloatingActionButtonVisible = true;
          });
        }
      } else if (isAtBottom && _isFloatingActionButtonVisible) {
        setState(() {
          _isFloatingActionButtonVisible = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(filteredTasks);
    final currentQuickFilter = ref.watch(selectedQuickFilter);

    ref.listen<List<TaskModel>>(filteredTasks, (previous, next) {
      _updateFabVisibility();
    });

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
        child: ExpandableFab(
          distance: 64,
          children: [
            ActionButton(
              icon: Icon(Icons.task),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TaskFormScreen(),
                ),
              ),
            ),
            ActionButton(
              icon: Icon(Icons.list),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ListFormScreen(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
