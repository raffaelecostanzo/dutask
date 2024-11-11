import 'package:dutask/utils/functions.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.selectedValue,
    required this.title,
    required this.icon,
    required this.options,
    required this.onOptionChanged,
  });

  final Object selectedValue;
  final String title;
  final IconData icon;
  final List options;
  final ValueChanged onOptionChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(dynamicToString(selectedValue)),
      onTap: () => showModalBottomSheet(
        barrierLabel: 'sss',
        showDragHandle: true,
        context: context,
        builder: (context) {
          return Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                    child: IconButton(
                      onPressed: Navigator.of(context).pop,
                      icon: Icon(Icons.close),
                    ),
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              Divider(),
              Expanded(
                child: ListView(
                  children: options.map((option) {
                    return RadioListTile(
                      value: option,
                      groupValue: selectedValue,
                      title: Text(
                        dynamicToString(option),
                      ),
                      onChanged: (onChanged) {
                        onOptionChanged(onChanged);
                        Navigator.of(context).pop();
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
