import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:dutask/providers/task_filter_provider.dart';
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
    final tasks = ref.watch(filteredTasksProvider);
    final selectedFilter = ref.watch(taskFilterProvider);

    return Scaffold(
      drawer: MainDrawer(),
      endDrawer: FilterSettingsDrawer(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Dutask'),
              snap: true,
              floating: true,
              actions: [
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),
                ),
              ],
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverFilterChipsBarDelegate(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FilterChipsBar(
                          selectedFilter: selectedFilter,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                  ],
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
                      (_, index) => TaskItem(tasks[index]),
                      childCount: tasks.length,
                    ),
                  ),
            SliverToBoxAdapter(
              child: SizedBox(height: 128), // Spazio vuoto di 128px
            ),
          ],
        ),
      ),
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
                      builder: (_) => const ListFormScreen(),
                    ),
                  ),
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerHighest),
          SizedBox(height: 16),
          FloatingActionButton(
            tooltip: 'Task',
            heroTag: 'task',
            child: Icon(Icons.task),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const TaskFormScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverFilterChipsBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverFilterChipsBarDelegate({required this.child});

  @override
  double get minExtent => 72.0;
  @override
  double get maxExtent => 72.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SliverFilterChipsBarDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}
