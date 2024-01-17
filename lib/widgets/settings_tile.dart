import 'package:dutask/utils/functions.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.currentValue,
    required this.title,
    required this.icon,
    required this.options,
    required this.onOptionChanged,
  });

  final dynamic currentValue;
  final String title;
  final IconData icon;
  final List options;
  final ValueChanged onOptionChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(dynamicToString(currentValue)),
      onTap: () {
        showModalBottomSheet(
          showDragHandle: true,
          context: context,
          builder: (context) {
            return Column(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (_, index) => ListTile(
                      leading: Icon(
                        options[index] == currentValue ? Icons.check : null,
                      ),
                      title: Text(
                        dynamicToString(options[index]),
                      ),
                      onTap: () {
                        onOptionChanged(options[index]);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
