import 'package:dutask/models/task_model.dart';
import 'package:dutask/providers/lists_provider.dart';
import 'package:dutask/providers/tasks_provider.dart';
import 'package:dutask/utils/constants.dart';
import 'package:dutask/utils/extensions/common_extensions.dart';
import 'package:dutask/utils/extensions/task_status_extensions.dart';
import 'package:dutask/utils/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../data/list_icons.dart';

class TaskFormScreen extends ConsumerStatefulWidget {
  const TaskFormScreen({Key? key, this.task}) : super(key: key);

  final TaskModel? task;

  @override
  ConsumerState<TaskFormScreen> createState() => _TaskFormViewState();
}

class _TaskFormViewState extends ConsumerState<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String _screenTitle = 'New task';
  String _title = '';
  String _description = '';
  TaskStatus _status = TaskStatus.active;
  String? _listId = '';

  final _dateTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _screenTitle = widget.task!.title;
      _title = widget.task!.title;
      _description = widget.task!.description ?? '';
      _status = widget.task!.status;
      _listId = widget.task!.listId;
      if (widget.task!.dueDate != null) {
        _dateTextController.text = dateFormat.format(widget.task!.dueDate!);
      }
    }
  }

  @override
  void dispose() {
    _dateTextController.dispose();
    super.dispose();
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
      setState(() {
        _dateTextController.text = dateFormat.format(pickedDate);
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String snackBarMessage;
      final taskNotifier = ref.read(tasksProvider.notifier);

      if (widget.task != null) {
        taskNotifier.updateTask(
          widget.task!.id,
          widget.task!.copyWith(
            title: _title,
            description: _description,
            dueDate: _dateTextController.text.getDateOrNull(),
            status: _status,
            listId: _listId,
          ),
        );
        snackBarMessage = 'Task updated successfully';
      } else {
        taskNotifier.createTask(
          TaskModel(
            id: uuid.v4(),
            title: _title,
            description: _description,
            dueDate: _dateTextController.text.getDateOrNull(),
            status: _status,
            listId: _listId,
          ),
        );
        snackBarMessage = 'Task created successfully';
      }
      Navigator.of(context).pop();
      context.showSnackBarWithUndo(taskNotifier.undo, snackBarMessage);
    }
  }

  Widget _buildTitleField() {
    return TextFormField(
      validator: (value) => FormValidator.title(value),
      initialValue: _title,
      maxLength: 63,
      autofocus: widget.task == null,
      decoration: const InputDecoration(
        label: Text('Title'),
        border: OutlineInputBorder(),
      ),
      onSaved: (value) {
        _title = value!;
      },
    );
  }

  Widget _buildDueDateField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            validator: (value) => FormValidator.dueDate(value),
            controller: _dateTextController,
            maxLength: 10,
            decoration: InputDecoration(
              label: Text('Due date'),
              hintText: dateFieldHintText,
              counterText: null,
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.datetime,
            inputFormatters: [MaskTextInputFormatter(mask: '##/##/####')],
          ),
        ),
        const SizedBox(width: 16),
        OutlinedButton.icon(
          label: const Text('Pick a date'),
          onPressed: _showDatePicker,
          icon: const Icon(Icons.edit_calendar),
        ),
      ],
    );
  }

  Widget _buildStatusField() {
    return Row(
      children: [
        Checkbox(
          tristate: true,
          value: _status.mapToTristate(),
          onChanged: (value) {
            setState(() {
              _status = _status.toggle();
            });
          },
        ),
        const SizedBox(width: 16),
        Text(
          'Status:',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(width: 16),
        Text(
          _status.mapToText(),
          style: const TextStyle(
            fontSize: 16,
          ),
        )
      ],
    );
  }

  Widget _buildListField() {
    final lists = ref.read(listsProvider);
    final selectedList = lists.firstWhere(
      (list) => list.id == _listId,
      orElse: () => lists.first,
    );

    return DropdownMenu(
      initialSelection: selectedList.id,
      leadingIcon: Icon(iconMap[selectedList.icon]),
      label: Text('List'),
      onSelected: (String? value) {
        setState(() {
          _listId = value!;
        });
      },
      dropdownMenuEntries: lists.map((list) {
        return DropdownMenuEntry(
          value: list.id,
          label: list.title,
          leadingIcon: Icon(iconMap[list.icon]),
        );
      }).toList(),
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      initialValue: _description,
      decoration: const InputDecoration(
        label: Text('Description'),
        border: OutlineInputBorder(),
      ),
      minLines: 5,
      maxLines: 10,
      onSaved: (value) {
        _description = value ?? '';
      },
    );
  }

  void _delete() {
    final taskNotifier = ref.read(tasksProvider.notifier);
    taskNotifier.deleteTask(widget.task!.id);
    Navigator.of(context).pop();
    context.showSnackBarWithUndo(
        taskNotifier.undo, 'Task deleted successfully');
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
                _buildTitleField(),
                const SizedBox(height: 20),
                _buildDueDateField(),
                const SizedBox(height: 20),
                _buildStatusField(),
                const SizedBox(height: 24),
                _buildListField(),
                const SizedBox(height: 40),
                _buildDescriptionField(),
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
