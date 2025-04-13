import 'package:dutask/data/list_icons.dart';
import 'package:dutask/providers/lists_provider.dart';
import 'package:dutask/screens/list_form_screen.dart';
import 'package:dutask/screens/settings_screen.dart';
import 'package:dutask/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(listsProvider);

    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: kSafeAreaTopPadding,
                left: kSafeAreaLeftPadding,
              ),
              alignment: AlignmentDirectional.topStart,
              child: Text(
                'Dutask',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Divider(),
            Expanded(
              child: lists.isEmpty
                  ? Center(
                      child: Text('There are no lists at the moment.'),
                    )
                  : ListView(
                      padding: EdgeInsets.zero,
                      children: lists.map((list) {
                        return ListTile(
                          leading: Icon(listIcons[list.icon]),
                          title: Text(list.title),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ListFormScreen(list: list),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: const Text('Help and Feedback'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: const Text('About'),
              onTap: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}
