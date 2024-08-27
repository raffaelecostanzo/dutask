import 'package:dutask/views/settings_view.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  alignment: AlignmentDirectional.topStart,
                  child: Text('Dutask',
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                Divider()
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.list_alt_outlined),
                        title: const Text('My Day'),
                        selected: false,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.list_alt_outlined),
                        title: const Text('Recurrences'),
                        selected: false,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.list_alt_outlined),
                        title: const Text('Important'),
                        selected: false,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Divider(),
              ListTile(
                leading: Icon(Icons.settings_outlined),
                title: const Text('Settings'),
                selected: false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsView(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.help_outline),
                title: const Text('Help and Feedback'),
                selected: false,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: const Text('About'),
                selected: false,
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
