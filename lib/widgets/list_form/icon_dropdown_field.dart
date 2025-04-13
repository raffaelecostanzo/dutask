import 'package:dutask/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:dutask/utils/form_validator.dart';
import 'package:dutask/data/list_icons.dart';
import 'package:dutask/utils/functions.dart';
import 'package:dutask/widgets/dropdown_menu_formfield.dart';

class IconDropdownField extends StatelessWidget {
  const IconDropdownField({
    super.key,
    required this.selectedIcon,
    required this.onChanged,
    required this.onSaved,
  });

  final String selectedIcon;
  final ValueChanged<String> onChanged;
  final FormFieldSetter<String?> onSaved;

  @override
  Widget build(BuildContext context) {
    return DropdownMenuFormField<String>(
      requestFocusOnTap: true,
      width: MediaQuery.of(context).size.width - kFormHorizontalPadding,
      initialValue: selectedIcon,
      leadingIcon: Icon(
        selectedIcon.isNotEmpty ? listIcons[selectedIcon] : Icons.question_mark,
      ),
      label: const Text('Icon'),
      onSaved: onSaved,
      validator: (value) => FormValidator.icon(
        value,
        listIcons.keys.toList(),
      ),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
      dropdownMenuEntries: listIcons.keys.map((icon) {
        return DropdownMenuEntry(
          value: icon,
          label: getIconName(icon),
          leadingIcon: Icon(listIcons[icon]),
        );
      }).toList(),
    );
  }
}
