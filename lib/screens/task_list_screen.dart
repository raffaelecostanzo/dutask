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

class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen> {
  bool _isFabVisible = true;

  bool _updateFabVisibility(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollUpdateNotification) {
      if (scrollNotification.scrollDelta! > 0 && _isFabVisible) {
        setState(() {
          _isFabVisible = false;
        });
      } else if (scrollNotification.scrollDelta! < 0 && !_isFabVisible) {
        setState(() {
          _isFabVisible = true;
        });
      }
    } else if (scrollNotification is OverscrollNotification) {
      if (scrollNotification.overscroll > 0 && _isFabVisible) {
        // Scrolling down
        setState(() {
          _isFabVisible = false;
        });
      } else if (scrollNotification.overscroll < 0 && !_isFabVisible) {
        // Scrolling up
        setState(() {
          _isFabVisible = true;
        });
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(filteredTasks);
    final currentQuickFilter = ref.watch(selectedQuickFilter);

    return SafeArea(
      child: Scaffold(
        drawer: MainDrawer(),
        endDrawer: FilterSettingsDrawer(),
        body: NotificationListener<ScrollNotification>(
          onNotification: _updateFabVisibility,
          child: CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
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
                  preferredSize: Size.fromHeight(48),
                  child: FilterChipsBar(
                    selectedFilter: currentQuickFilter,
                  ),
                ),
              ),
              tasks.isEmpty
                  ? SliverFillRemaining(
                      child: Center(
                        child: Text('There are no tasks at the moment.'),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => TaskItem(tasks[index]),
                        childCount: tasks.length,
                      ),
                    ),
            ],
          ),
        ),
        floatingActionButton: Visibility(
          visible: _isFabVisible,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'list',
                child: Icon(Icons.list),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListFormScreen(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              FloatingActionButton(
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
        ),
      ),
    );
  }
}
