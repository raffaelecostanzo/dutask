import 'package:dutask/extensions/string_extension.dart';
import 'package:dutask/models/task_model.dart';
import 'package:dutask/providers/tasks_provider.dart';
import 'package:dutask/utils/constants.dart';
import 'package:dutask/extensions/build_context_extension.dart';
import 'package:dutask/widgets/task_form/description_field.dart';
import 'package:dutask/widgets/task_form/due_date_field.dart';
import 'package:dutask/widgets/task_form/list_field.dart';
import 'package:dutask/widgets/task_form/status_field.dart';
import 'package:dutask/widgets/task_form/title_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskFormScreen extends ConsumerStatefulWidget {
  const TaskFormScreen({super.key, this.task});

  final TaskModel? task;

  @override
  ConsumerState<TaskFormScreen> createState() => _TaskFormViewState();
}

class _TaskFormViewState extends ConsumerState<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String _screenTitle = 'New task';
  String _title = '';
  TaskStatus _status = TaskStatus.active;
  String? _listId;
  String? _description;
  final _dateTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final task = widget.task;
    if (task != null) {
      _screenTitle = task.title;
      _title = task.title;
      _status = task.status;
      _listId = task.listId;
      _description = task.description;
      final dueDate = task.dueDate;
      if (dueDate != null) {
        _dateTextController.text = kDateFormat.format(dueDate);
      }
    }
  }

  void _delete() {
    final task = widget.task;
    if (task == null) return;

    final tasksNotifier = ref.read(tasksProvider.notifier);
    tasksNotifier.deleteTask(task.id);
    Navigator.of(context).pop();

    const snackBarMessage = 'Task deleted successfully';
    context.showSnackBarWithUndo(tasksNotifier.undo, snackBarMessage);
  }

  void _showDatePicker() async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(1970, 1, 1);
    final DateTime lastDate = DateTime(now.year + 10, 12, 31);
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (pickedDate != null) {
      setState(() => _dateTextController.text = kDateFormat.format(pickedDate));
    }
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final tasksNotifier = ref.read(tasksProvider.notifier);
      final task = widget.task;
      String snackBarMessage;

      if (task != null) {
        tasksNotifier.updateTask(
          task.id,
          task.copyWith(
            title: _title,
            dueDate: _dateTextController.text.getDateOrNull(),
            status: _status,
            listId: _listId,
            description: _description,
          ),
        );
        snackBarMessage = 'Task updated successfully';
      } else {
        tasksNotifier.createTask(
          TaskModel(
            id: kUuid.v4(),
            title: _title,
            dueDate: _dateTextController.text.getDateOrNull(),
            status: _status,
            listId: _listId,
            description: _description,
          ),
        );
        snackBarMessage = 'Task created successfully';
      }

      Navigator.of(context).pop();
      context.showSnackBarWithUndo(tasksNotifier.undo, snackBarMessage);
    }
  }

  @override
  void dispose() {
    _dateTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screenTitle),
        actions: widget.task != null
            ? [IconButton(icon: Icon(Icons.delete), onPressed: _delete)]
            : null,
      ),
      body: SizedBox(
        height: double.infinity,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                TitleField(
                  initialValue: _title,
                  onSaved: (value) => _title = value,
                ),
                const SizedBox(height: 20),
                DueDateField(
                  controller: _dateTextController,
                  onTap: _showDatePicker,
                ),
                const SizedBox(height: 40),
                StatusField(
                  value: _status,
                  onChanged: (value) => setState(() => _status = value),
                  onSaved: (value) {
                    if (value != null) _status = value;
                  },
                ),
                const SizedBox(height: 40),
                ListField(
                  selectedId: _listId,
                  onChanged: (value) => setState(() => _listId = value),
                  onSaved: (value) => _listId = value,
                ),
                const SizedBox(height: 40),
                DescriptionField(
                  initialValue: _description,
                  onSaved: (value) => _description = value ?? '',
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.done),
        onPressed: _submit,
      ),
    );
  }
}
