import 'package:dutask/views/task_form_view.dart';
import 'package:dutask/widgets/bottom_date_nav_bar.dart';
import 'package:dutask/widgets/task_list.dart';
import 'package:flutter/material.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dutask'),
      ),
      body: TaskList(),
      bottomNavigationBar: BottomDayNavBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TaskFormView()),
        ),
      ),
    );
  }
}
