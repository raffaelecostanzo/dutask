import 'package:dutask/providers/theme_provider.dart';
import 'package:dutask/themes/default_theme.dart';
import 'package:dutask/views/task_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: defaultLightTheme,
      darkTheme: defaultDarkTheme,
      themeMode: themeMode,
      home: TaskListView(),
    );
  }
}
