import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:dutask/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterNavigationBar extends ConsumerWidget {
  final List<BottomNavigationBarItem> navBarItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.format_list_bulleted), label: 'All'),
    BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Yesterday'),
    BottomNavigationBarItem(icon: Icon(Icons.today), label: 'Today'),
    BottomNavigationBarItem(
        icon: Icon(Icons.calendar_month), label: 'Tomorrow'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFilter = ref.watch(taskDateFilter);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: navBarItems,
      currentIndex: dateFilter.mapToBottomNavigationBarIndex(),
      onTap: (index) =>
          ref.read(taskDateFilter.notifier).state = index.mapToDateFilter(),
    );
  }
}
