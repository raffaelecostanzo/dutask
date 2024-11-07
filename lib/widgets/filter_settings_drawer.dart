import 'package:dutask/data/quick_filters.dart';
import 'package:dutask/extensions/common_extensions.dart';
import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:dutask/providers/quick_filter_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterSettingsDrawer extends ConsumerWidget {
  const FilterSettingsDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentQuickFilter = ref.watch(selectedQuickFilter);
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, left: 20),
              alignment: AlignmentDirectional.topStart,
              child: Text('Quick filter settings',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            Divider(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: quickFilters.map((filter) {
                  return RadioListTile(
                    value: filter,
                    groupValue: currentQuickFilter,
                    onChanged: (onChangedFilter) {
                      ref.read(selectedQuickFilter.notifier).state =
                          onChangedFilter!;
                      ref.read(taskStatusFilter.notifier).state =
                          TaskStatusFilter.all;
                      ref.read(taskDateFilter.notifier).state =
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
