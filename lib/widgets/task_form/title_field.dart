import 'package:dutask/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:dutask/utils/form_validator.dart';

class TitleField extends StatelessWidget {
  const TitleField({
    super.key,
    required this.initialValue,
    required this.onSaved,
  });

  final String initialValue;
  final ValueChanged<String> onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: FormValidator.title,
      initialValue: initialValue,
      maxLength: kMaxTitleLength,
      autofocus: true,
      decoration: const InputDecoration(
        label: Text('Title'),
        border: OutlineInputBorder(),
      ),
      onSaved: (value) => onSaved(value ?? ''),
    );
  }
}
