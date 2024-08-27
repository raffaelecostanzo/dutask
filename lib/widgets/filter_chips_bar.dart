import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef FilterToTextMapper<T> = String Function(T filter);

class FilterChipsBar<T> extends ConsumerWidget {
  final StateProvider<T> selectedFilterProvider;
  final List<T> filters;
  final FilterToTextMapper<T> filterToText;

  const FilterChipsBar.FilterChipsBar({
    required this.selectedFilterProvider,
    required this.filters,
    required this.filterToText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(selectedFilterProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(width: 16),
          ...filters.map((filter) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: FilterChip(
                label: Text(filterToText(filter)),
                selected: selectedFilter == filter,
                onSelected: (_) => ref.read(selectedFilterProvider.notifier).state = filter,
              ),
            );
          },
          ).toList(),
        ],
      ),
    );
  }
}