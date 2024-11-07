import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:dutask/extensions/task_date_extensions.dart';
import 'package:dutask/extensions/task_status_extensions.dart';
import 'package:dutask/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterChipsBar extends ConsumerWidget {
  final FilterType selectedFilter;

  const FilterChipsBar({
    required this.selectedFilter,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStatusFilterValue = ref.watch(taskStatusFilter);
    final selectedDateFilterValue = ref.watch(taskDateFilter);

    final List<FilterChip> filterChips = switch (selectedFilter) {
      FilterType.status => TaskStatusFilter.values.map((filter) {
          return FilterChip(
            label: Text(filter.mapToText()),
            selected: selectedStatusFilterValue == filter,
            onSelected: (_) =>
                ref.read(taskStatusFilter.notifier).state = filter,
          );
        }).toList(),
      FilterType.dueDate => TaskDateFilter.values.map((filter) {
          return FilterChip(
            label: Text(filter.mapToText()),
            selected: selectedDateFilterValue == filter,
            onSelected: (_) => ref.read(taskDateFilter.notifier).state = filter,
          );
        }).toList()
    };

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Wrap(
          spacing: 8.0,
          children: filterChips,
        ),
      ),
    );
  }
}
