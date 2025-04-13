import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:dutask/utils/constants.dart';
import 'package:dutask/utils/form_validator.dart';

const kTextFieldMaxLength = 10;

class DueDateField extends StatelessWidget {
  const DueDateField({
    super.key,
    required this.controller,
    required this.onTap,
  });

  final TextEditingController controller;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: FormValidator.dueDate,
      controller: controller,
      maxLength: kTextFieldMaxLength,
      decoration: InputDecoration(
        label: const Text('Due date'),
        hintText: kDateFieldHintText,
        counterText: '',
        border: const OutlineInputBorder(),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: IconButton(
            icon: const Icon(Icons.edit_calendar),
            onPressed: onTap,
          ),
        ),
      ),
      keyboardType: TextInputType.datetime,
      inputFormatters: [MaskTextInputFormatter(mask: '##/##/####')],
    );
  }
}
