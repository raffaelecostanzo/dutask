import 'package:flutter/material.dart';

class DropdownMenuFormField<T> extends FormField<T> {
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final Widget? leadingIcon;
  final Widget? label;
  final double? width;
  final bool requestFocusOnTap;

  DropdownMenuFormField({
    Key? key,
    required this.dropdownMenuEntries,
    this.leadingIcon,
    this.label,
    this.width,
    this.requestFocusOnTap = true,
    T? initialValue,
    FormFieldSetter<T>? onSaved,
    FormFieldValidator<T>? validator,
    ValueChanged<T?>? onChanged,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  }) : super(
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autovalidateMode,
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
