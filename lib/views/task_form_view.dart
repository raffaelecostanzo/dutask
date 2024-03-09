import 'package:dutask/models/task_model.dart';
import 'package:dutask/providers/tasks_provider.dart';
import 'package:dutask/utils/extensions.dart';
import 'package:dutask/utils/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dutask/utils/constants.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TaskFormView extends ConsumerStatefulWidget {
  const TaskFormView({super.key, this.task});

  final TaskModel? task;

  @override
  ConsumerState<TaskFormView> createState() => _TaskFormViewState();
}

class _TaskFormViewState extends ConsumerState<TaskFormView> {
  final _formKey = GlobalKey<FormState>();
  final _titleTextController = TextEditingController();
  final _dateTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  TaskStatus _status = TaskStatus.active;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleTextController.text = widget.task!.title;
      if (widget.task!.dueDate != null) {
        _dateTextController.text = dateFormat.format(widget.task!.dueDate!);
      }
      if (widget.task!.description != null) {
        _descriptionTextController.text = widget.task!.description!;
      }
      _status = widget.task!.status;
    }
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _dateTextController.dispose();
    _descriptionTextController.dispose();
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
      _dateTextController.text = dateFormat.format(pickedDate);
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String? snackBarMessage;
      final taskNotifier = ref.read(tasksProvider.notifier);

      if (widget.task != null) {
        taskNotifier.updateTask(
          widget.task!.id,
          widget.task!.copyWith(
            title: _titleTextController.text,
            description: _descriptionTextController.text,
            dueDate: _dateTextController.text.getDateOrNull(),
            status: _status,
          ),
        );
        snackBarMessage = 'Task updated successfully';
      } else {
        taskNotifier.createTask(
          TaskModel(
            id: uuid.v4(),
            title: _titleTextController.text,
            description: _descriptionTextController.text,
            dueDate: _dateTextController.text.getDateOrNull(),
            status: _status,
            membershipLists: null,
          ),
        );
        snackBarMessage = 'Task created successfullly';
      }
      Navigator.of(context).pop();
      context.showSnackBarWithUndo(taskNotifier, snackBarMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'New task' : widget.task!.title),
      ),
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (value) => FormValidator.title(value),
                    controller: _titleTextController,
                    maxLength: 63,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
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
                            counterText: '',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.datetime,
                          inputFormatters: [
                            MaskTextInputFormatter(mask: "##/##/####")
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      OutlinedButton.icon(
                        label: Text('Pick a date'),
                        onPressed: _showDatePicker,
                        icon: const Icon(Icons.calendar_month),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        tristate: true,
                        value: _status.mapToTristate(),
                        onChanged: (value) {
                          setState(() {
                            value = value.toggle();
                            _status = _status.toggle();
                          });
                        },
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Status: ${_status.mapToText()}',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _descriptionTextController,
                    decoration: const InputDecoration(
                      label: Text('Description'),
                      border: OutlineInputBorder(),
                    ),
                    minLines: 5,
                    maxLines: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: _submit,
      ),
    );
  }
}
