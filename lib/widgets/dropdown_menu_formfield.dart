import 'package:flutter/material.dart';

class DropdownMenuFormField<T> extends FormField<T> {
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final Widget? leadingIcon;
  final Widget? label;
  final double? width;
  final bool requestFocusOnTap;

  DropdownMenuFormField({
    super.key,
    required this.dropdownMenuEntries,
    this.leadingIcon,
    this.label,
    this.width,
    this.requestFocusOnTap = true,
    super.initialValue,
    super.onSaved,
    super.validator,
    ValueChanged<T?>? onChanged,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,
  }) : super(
          builder: (FormFieldState<T> state) {
            return DropdownMenu<T>(
              errorText: state.errorText,
              requestFocusOnTap: requestFocusOnTap,
              width: width,
              initialSelection: state.value,
              leadingIcon: leadingIcon,
              label: label,
              dropdownMenuEntries: dropdownMenuEntries,
              onSelected: (T? value) {
                state.didChange(value);
                if (onChanged != null) {
                  onChanged(value);
                }
              },
              menuHeight: 300,
            );
          },
        );
}
