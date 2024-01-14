import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:dutask/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskListFilterRow extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(taskStatusFilter);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: TaskStatusFilter.values.map((filter) {
        return ChoiceChip(
          label: Text(filter.mapToText()),
          selected: selectedFilter == filter,
          onSelected: (_) => ref.read(taskStatusFilter.notifier).state = filter,
        );
      }).toList(),
    );
  }
}
