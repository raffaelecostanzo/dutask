import 'package:dutask/extensions/filter_type_extension.dart';
import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:dutask/providers/task_filter_provider.dart';
import 'package:dutask/types/task_date_filter.dart';
import 'package:dutask/types/task_filter.dart';
import 'package:dutask/types/task_status_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterSettingsDrawer extends ConsumerWidget {
  const FilterSettingsDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(taskFilterProvider);
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, left: 20),
              alignment: AlignmentDirectional.topStart,
              child: Text(
                'Filter settings',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Divider(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: taskFilters.map((filter) {
                  return RadioListTile(
                    value: filter,
                    groupValue: selectedFilter,
                    onChanged: (onChangedFilter) {
                      ref.read(taskFilterProvider.notifier).state =
                          onChangedFilter!;
                      ref.read(taskStatusFilterProvider.notifier).state =
                          TaskStatusFilter.all;
                      ref.read(taskDateFilterProvider.notifier).state =
                          TaskDateFilter.all;
                    },
                    title: Text(filter.mapToText()),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
