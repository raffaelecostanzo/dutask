import 'package:dutask/utils/constants.dart';
import 'package:flutter/material.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    super.key,
    required this.initialValue,
    required this.onSaved,
  });

  final String? initialValue;
  final ValueChanged<String?> onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: const InputDecoration(
        label: Text('Description'),
        border: OutlineInputBorder(),
      ),
      minLines: kMinTextFieldLines,
      maxLines: kMaxTextFieldLines,
      onSaved: onSaved,
    );
  }
}
