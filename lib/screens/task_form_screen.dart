import 'package:dutask/data/list_icons.dart';
import 'package:dutask/extensions/string_extension.dart';
import 'package:dutask/models/list_model.dart';
import 'package:dutask/models/task_model.dart';
import 'package:dutask/providers/lists_provider.dart';
import 'package:dutask/providers/tasks_provider.dart';
import 'package:dutask/screens/list_form_screen.dart';
import 'package:dutask/utils/constants.dart';
import 'package:dutask/extensions/build_context_extension.dart';
import 'package:dutask/extensions/task_status_extension.dart';
import 'package:dutask/utils/form_validator.dart';
import 'package:dutask/widgets/dropdown_menu_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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

    if (widget.task != null) {
      final widgetTask = widget.task!;
      _screenTitle = widgetTask.title;
      _title = widgetTask.title;
      _status = widgetTask.status;
      _listId = widgetTask.listId;
      _description = widgetTask.description;
      if (widgetTask.dueDate != null) {
        _dateTextController.text = dateFormat.format(widgetTask.dueDate!);
      }
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
                _buildTitleField(),
                const SizedBox(height: 20),
                _buildDueDateField(),
                const SizedBox(height: 40),
                _buildStatusField(),
                const SizedBox(height: 40),
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

  Widget _buildTitleField() {
    return TextFormField(
      validator: (onFormTitle) => FormValidator.title(onFormTitle),
      initialValue: _title,
      maxLength: 63,
      autofocus: widget.task == null,
      decoration: const InputDecoration(
        label: Text('Title'),
        border: OutlineInputBorder(),
      ),
      onSaved: (onTitleSaved) => _title = onTitleSaved!,
    );
  }

  Widget _buildDueDateField() {
    return TextFormField(
      validator: (onDueDateValidated) =>
          FormValidator.dueDate(onDueDateValidated),
      controller: _dateTextController,
      maxLength: 10,
      decoration: InputDecoration(
        label: Text('Due date'),
        hintText: dateFieldHintText,
        counterText: '',
        border: OutlineInputBorder(),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: IconButton(
            icon: Icon(Icons.edit_calendar),
            onPressed: _showDatePicker,
          ),
        ),
      ),
      keyboardType: TextInputType.datetime,
      inputFormatters: [MaskTextInputFormatter(mask: '##/##/####')],
    );
  }

  Widget _buildStatusField() {
    return DropdownMenuFormField<TaskStatus>(
      requestFocusOnTap: false,
      width: MediaQuery.of(context).size.width - 32,
      initialValue: _status,
      leadingIcon: Icon(_status.mapToIcon()),
      label: Text('Status'),
      onSaved: (onStatusSaved) {
        if (onStatusSaved != null) {
          _status = onStatusSaved;
        }
      },
      onChanged: (onStatusChanged) {
        if (onStatusChanged != null) {
          setState(() => _status = onStatusChanged);
        }
      },
      dropdownMenuEntries: TaskStatus.values.map((status) {
        return DropdownMenuEntry(
          value: status,
          label: status.mapToText(),
          leadingIcon: Icon(status.mapToIcon()),
        );
      }).toList(),
    );
  }

  Widget _buildListField() {
    final lists = ref.watch(listsProvider);
    final isListEmpty = lists.isEmpty;
    final ListModel? taskList = lists.firstWhereOrNull(
      (list) => list.id == _listId,
    );

    return DropdownMenuFormField<String?>(
      requestFocusOnTap: true,
      width: MediaQuery.of(context).size.width - 32,
      initialValue: isListEmpty || taskList == null ? '__no_list__' : _listId,
      leadingIcon: Icon(
        _listId == '__no_list__'
            ? Icons.close
            : taskList == null
                ? Icons.question_mark
                : listIcons[taskList.icon],
      ),
      label: Text('List'),
      onSaved: (onSavedList) => _listId = onSavedList,
      validator: (onListIdValidated) => FormValidator.list(
        onListIdValidated,
        lists.map((list) => list.id).toList(),
      ),
      onChanged: (onListChanged) => setState(() => _listId = onListChanged),
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: '__no_list__',
          label: 'No list',
          leadingIcon: Icon(Icons.close),
          trailingIcon: isListEmpty
              ? IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ListFormScreen(),
                    ),
                  ),
                  icon: Icon(Icons.add),
                )
              : null,
        ),
        ...lists.map((list) {
          return DropdownMenuEntry(
            value: list.id,
            label: list.title,
            leadingIcon: Icon(listIcons[list.icon]),
          );
        })
      ],
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
      onSaved: (onDescriptionSaved) {
        _description = onDescriptionSaved ?? '';
      },
    );
  }

  void _delete() {
    final tasksNotifier = ref.read(tasksProvider.notifier);
    tasksNotifier.deleteTask(widget.task!.id);
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
      setState(() => _dateTextController.text = dateFormat.format(pickedDate));
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String snackBarMessage;
      final tasksNotifier = ref.read(tasksProvider.notifier);

      if (widget.task != null) {
        tasksNotifier.updateTask(
          widget.task!.id,
          widget.task!.copyWith(
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
            id: uuid.v4(),
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
}
