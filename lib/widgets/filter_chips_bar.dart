import 'package:dutask/extensions/task_date_filter_extension.dart';
import 'package:dutask/extensions/task_status_filter_extension.dart';
import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:dutask/types/task_date_filter.dart';
import 'package:dutask/types/task_filter.dart';
import 'package:dutask/types/task_status_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kSingleChildScrollViewSpacing = 8.0;

class FilterChipsBar extends ConsumerWidget {
  const FilterChipsBar({
    required this.selectedFilter,
    super.key,
  });

  final TaskFilter selectedFilter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStatusFilter = ref.watch(taskStatusFilterProvider);
    final selectedDateFilter = ref.watch(taskDateFilterProvider);

    final List<FilterChip> filterChips = switch (selectedFilter) {
      TaskFilter.status => TaskStatusFilter.values.map((filter) {
          return FilterChip(
            label: Text(filter.mapToText()),
            selected: selectedStatusFilter == filter,
            onSelected: (_) =>
                ref.read(taskStatusFilterProvider.notifier).state = filter,
          );
        }).toList(),
      TaskFilter.dueDate => TaskDateFilter.values.map((filter) {
          return FilterChip(
            label: Text(filter.mapToText()),
            selected: selectedDateFilter == filter,
            onSelected: (_) =>
                ref.read(taskDateFilterProvider.notifier).state = filter,
          );
        }).toList()
    };

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Wrap(
          spacing: kSingleChildScrollViewSpacing,
          children: filterChips,
        ),
      ),
    );
  }
}
