import 'package:dutask/providers/theme_provider.dart';
import 'package:dutask/themes/default_themes.dart';
import 'package:dutask/screens/task_list_screen.dart';
import 'package:dutask/widgets/system_ui_themer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: Main(),
    ),
  );
}

class Main extends ConsumerWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: defaultLightTheme,
      darkTheme: defaultDarkTheme,
      themeMode: themeMode,
      home: TaskListScreen(),
      builder: (context, child) {
        return SystemUiThemer(
          child: child ?? const SizedBox(),
        );
      },
    );
  }
}
