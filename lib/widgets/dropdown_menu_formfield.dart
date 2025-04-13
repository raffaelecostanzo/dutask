import 'package:flutter/material.dart';

const kDropdownMenuFieldHeight = 300.0;

class DropdownMenuFormField<T> extends FormField<T> {
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
    super.enabled,
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
              menuHeight: kDropdownMenuFieldHeight,
            );
          },
        );

  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final Widget? leadingIcon;
  final Widget? label;
  final double? width;
  final bool requestFocusOnTap;
}
