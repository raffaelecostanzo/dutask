import 'package:dutask/models/list_model.dart';
import 'package:dutask/providers/lists_provider.dart';
import 'package:dutask/extensions/build_context_extension.dart';
import 'package:dutask/utils/constants.dart';
import 'package:dutask/utils/form_validator.dart';
import 'package:dutask/widgets/list_form/icon_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListFormScreen extends ConsumerStatefulWidget {
  const ListFormScreen({super.key, this.list});

  final ListModel? list;

  @override
  ConsumerState<ListFormScreen> createState() => _ListFormViewState();
}

class _ListFormViewState extends ConsumerState<ListFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String _screenTitle = "New list";
  String _title = '';
  String? _description;
  String _icon = '';

  @override
  void initState() {
    super.initState();

    final list = widget.list;
    if (list != null) {
      _screenTitle = list.title;
      _title = list.title;
      _description = list.description;
      _icon = list.icon;
    }
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final listsNotifier = ref.read(listsProvider.notifier);
      final list = widget.list;
      String snackBarMessage;

      if (list != null) {
        listsNotifier.updateList(
          list.id,
          list.copyWith(
            title: _title,
            icon: _icon,
            description: _description,
          ),
        );
        snackBarMessage = 'List updated successfully';
      } else {
        listsNotifier.createList(
          ListModel(
            id: kUuid.v4(),
            title: _title,
            icon: _icon,
            description: _description,
          ),
        );
        snackBarMessage = 'List created successfully';
      }

      Navigator.of(context).pop();
      context.showSnackBarWithUndo(listsNotifier.undo, snackBarMessage);
    }
  }

  void _delete() {
    final list = widget.list;
    if (list == null) return;

    final listsNotifier = ref.read(listsProvider.notifier);
    listsNotifier.deleteList(list.id);

    Navigator.of(context).pop();
    context.showSnackBarWithUndo(
      listsNotifier.undo,
      'List deleted successfully',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screenTitle),
        actions: widget.list != null
            ? [IconButton(icon: Icon(Icons.delete), onPressed: _delete)]
            : null,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              TextFormField(
                initialValue: _title,
                maxLength: kMaxTitleLength,
                autofocus: widget.list == null,
                decoration: const InputDecoration(
                  label: Text('Title'),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => FormValidator.title(value),
                onSaved: (value) {
                  if (value != null) _title = value;
                },
              ),
              const SizedBox(height: 20),
              IconDropdownField(
                selectedIcon: _icon,
                onChanged: (value) => setState(() => _icon = value),
                onSaved: (value) {
                  if (value != null) _icon = value;
                },
              ),
              const SizedBox(height: 40),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(
                  label: Text('Description'),
                  border: OutlineInputBorder(),
                ),
                minLines: kMinTextFieldLines,
                maxLines: kMaxTextFieldLines,
                onSaved: (onDescriptionSaved) =>
                    _description = onDescriptionSaved,
              ),
            ],
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
