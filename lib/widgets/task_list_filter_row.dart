import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:dutask/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskListFilterRow extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(taskStatusFilter);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(width: 16),
          ...TaskStatusFilter.values.map(
            (filter) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: FilterChip(
                  label: Text(filter.mapToText()),
                  selected: selectedFilter == filter,
                  onSelected: (_) =>
                      ref.read(taskStatusFilter.notifier).state = filter,
                ),
              );
            },
          ).toList()
        ],
      ),
    );
  }
}
