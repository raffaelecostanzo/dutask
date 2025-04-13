import 'package:flutter/material.dart';
import 'package:dutask/models/task_model.dart';
import 'package:dutask/extensions/task_status_extension.dart';
import 'package:dutask/widgets/dropdown_menu_formfield.dart';

const kDropdownMenuFieldOffest = 32;

class StatusField extends StatelessWidget {
  const StatusField({
    super.key,
    required this.value,
    required this.onChanged,
    required this.onSaved,
  });

  final TaskStatus value;
  final ValueChanged<TaskStatus> onChanged;
  final ValueChanged<TaskStatus?> onSaved;

  @override
  Widget build(BuildContext context) {
    return DropdownMenuFormField<TaskStatus>(
      requestFocusOnTap: false,
      width: MediaQuery.of(context).size.width - kDropdownMenuFieldOffest,
      initialValue: value,
      leadingIcon: Icon(value.mapToIcon()),
      label: const Text('Status'),
      onSaved: onSaved,
      onChanged: (val) {
        if (val != null) onChanged(val);
      },
      dropdownMenuEntries: TaskStatus.values.map((status) {
        return DropdownMenuEntry(
          value: status,
          label: status.mapToText(),
          leadingIcon: Icon(status.mapToIcon()),
        );
      }).toList(),
    );
  }
}
