import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dutask/providers/lists_provider.dart';
import 'package:dutask/models/list_model.dart';
import 'package:dutask/utils/form_validator.dart';
import 'package:dutask/screens/list_form_screen.dart';
import 'package:dutask/widgets/dropdown_menu_formfield.dart';
import 'package:dutask/data/list_icons.dart';

const kDropdownMenuFieldOffest = 32;

class ListField extends ConsumerWidget {
  const ListField({
    super.key,
    required this.selectedId,
    required this.onChanged,
    required this.onSaved,
  });

  final String? selectedId;
  final ValueChanged<String?> onChanged;
  final ValueChanged<String?> onSaved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(listsProvider);
    final isListEmpty = lists.isEmpty;
    final ListModel? taskList =
        lists.firstWhereOrNull((list) => list.id == selectedId);

    return DropdownMenuFormField<String?>(
      requestFocusOnTap: true,
      width: MediaQuery.of(context).size.width - kDropdownMenuFieldOffest,
      initialValue:
          isListEmpty || taskList == null ? '__no_list__' : selectedId,
      leadingIcon: Icon(
        selectedId == '__no_list__'
            ? Icons.close
            : taskList == null
                ? Icons.question_mark
                : listIcons[taskList.icon],
      ),
      label: const Text('List'),
      onSaved: onSaved,
      validator: (value) => FormValidator.list(
        value,
        lists.map((list) => list.id).toList(),
      ),
      onChanged: onChanged,
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: '__no_list__',
          label: 'No list',
          leadingIcon: const Icon(Icons.close),
          trailingIcon: isListEmpty
              ? IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ListFormScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.add),
                )
              : null,
        ),
        ...lists.map((list) {
          return DropdownMenuEntry(
            value: list.id,
            label: list.title,
            leadingIcon: Icon(listIcons[list.icon]),
          );
        })
      ],
    );
  }
}
