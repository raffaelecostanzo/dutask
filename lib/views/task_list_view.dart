import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:dutask/views/settings_view.dart';
import 'package:dutask/views/task_form_view.dart';
import 'package:dutask/widgets/filter_navigation_bar.dart';
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
  bool _isFloatingActionButtonVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels > 0) {
          if (_isFloatingActionButtonVisible) {
            setState(() {
              _isFloatingActionButtonVisible = false;
            });
          }
        }
      } else {
        if (!_isFloatingActionButtonVisible) {
          setState(() {
            _isFloatingActionButtonVisible = true;
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
            icon: const Icon(Icons.filter_list_outlined),
            onPressed: () => null,
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    alignment: AlignmentDirectional.topStart,
                    height: 53,
                    child: Text('Dutask',
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  Divider()
                ],
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.list_alt_outlined),
                          title: const Text('My Day'),
                          selected: false,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.list_alt_outlined),
                          title: const Text('Recurrences'),
                          selected: false,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.list_alt_outlined),
                          title: const Text('Important'),
                          selected: false,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Divider(),
                ListTile(
                  leading: Icon(Icons.settings_outlined),
                  title: const Text('Settings'),
                  selected: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsView(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.help_outline),
                  title: const Text('Help and Feedback'),
                  selected: false,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info_outline),
                  title: const Text('About'),
                  selected: false,
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )
          ],
        ),
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
      bottomNavigationBar: FilterNavigationBar(),
      floatingActionButton: Visibility(
        visible: _isFloatingActionButtonVisible,
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
