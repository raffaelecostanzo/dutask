import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:dutask/utils/extensions/task_date_extensions.dart';
import 'package:dutask/utils/extensions/task_status_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterChipsBar extends ConsumerWidget {
  final Type selectedFilter;

  const FilterChipsBar({
    required this.selectedFilter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStatusFilterValue = ref.watch(taskStatusFilter);
    final selectedDateFilterValue = ref.watch(taskDateFilter);

    final List<Widget> filterChips =
        selectedFilter.toString() == 'TaskStatusFilter'
            ? TaskStatusFilter.values.map((filter) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FilterChip(
                    label: Text(filter.mapToText()),
                    selected: selectedStatusFilterValue == filter,
                    onSelected: (_) =>
                        ref.read(taskStatusFilter.notifier).state = filter,
                  ),
                );
              }).toList()
            : TaskDateFilter.values.map((filter) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FilterChip(
                    label: Text(filter.mapToText()),
                    selected: selectedDateFilterValue == filter,
                    onSelected: (_) =>
                        ref.read(taskDateFilter.notifier).state = filter,
                  ),
                );
              }).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(width: 16),
          ...filterChips,
        ],
      ),
    );
  }
}
