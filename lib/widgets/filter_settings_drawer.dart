import 'package:dutask/data/quick_filters.dart';
import 'package:dutask/providers/quick_filter_provider.dart';
import 'package:dutask/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterSettingsDrawer extends ConsumerWidget {
  const FilterSettingsDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentQuickFilter = ref.watch(selectedQuickFilter);
    return Drawer(
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
                  onChanged: (onChangedFilter) => ref
                      .read(selectedQuickFilter.notifier)
                      .state = onChangedFilter!,
                  title: Text(getTaskFilterName(filter)),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
