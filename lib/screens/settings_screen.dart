import 'package:dutask/providers/theme_provider.dart';
import 'package:dutask/widgets/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SettingsItem(
            currentValue: ref.watch(themeModeProvider),
            title: 'Theme',
            icon: Icons.palette,
            options: ThemeMode.values,
            onOptionChanged: (newValue) =>
                ref.read(themeModeProvider.notifier).state = newValue,
          )
        ],
      ),
    );
  }
}
