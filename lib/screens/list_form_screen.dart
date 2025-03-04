import 'package:dutask/data/list_icons.dart';
import 'package:dutask/models/list_model.dart';
import 'package:dutask/providers/lists_provider.dart';
import 'package:dutask/extensions/build_context_extension.dart';
import 'package:dutask/utils/constants.dart';
import 'package:dutask/utils/form_validator.dart';
import 'package:dutask/utils/functions.dart';
import 'package:dutask/widgets/dropdown_menu_formfield.dart';
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
    if (widget.list != null) {
      final widgetList = widget.list!;
      _screenTitle = widgetList.title;
      _title = widgetList.title;
      _description = widgetList.description;
      _icon = widgetList.icon;
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String snackBarMessage;
      final listsNotifier = ref.read(listsProvider.notifier);

      if (widget.list != null) {
        final widgetList = widget.list!;
        listsNotifier.updateList(
          widgetList.id,
          widgetList.copyWith(
            title: _title,
            icon: _icon,
            description: _description,
          ),
        );
        snackBarMessage = 'List updated successfully';
      } else {
        listsNotifier.createList(
          ListModel(
            id: uuid.v4(),
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
    final listsNotifier = ref.read(listsProvider.notifier);
    listsNotifier.deleteList(widget.list!.id);
    Navigator.of(context).pop();
    context.showSnackBarWithUndo(
        listsNotifier.undo, 'List deleted successfully');
  }

  Widget _buildIconDropdown() {
    return DropdownMenuFormField<String>(
      requestFocusOnTap: true,
      width: MediaQuery.of(context).size.width - 32,
      initialValue: _icon,
      leadingIcon: Icon(_icon != '' ? listIcons[_icon] : Icons.question_mark),
      label: Text('Icon'),
      onSaved: (String? value) {
        if (value != null) {
          _icon = value;
        }
      },
      validator: (String? value) => FormValidator.icon(
        value,
        listIcons.keys.toList(),
      ),
      onChanged: (String? value) {
        if (value != null) {
          setState(() {
            _icon = value;
          });
        }
      },
      dropdownMenuEntries: listIcons.keys.map((icon) {
        return DropdownMenuEntry(
          value: icon,
          label: getIconName(icon),
          leadingIcon: Icon(listIcons[icon]),
        );
      }).toList(),
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
                maxLength: 63,
                autofocus: widget.list == null,
                decoration: const InputDecoration(
                  label: Text('Title'),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => FormValidator.title(value),
                onSaved: (value) {
                  _title = value!;
                },
              ),
              const SizedBox(height: 20),
              _buildIconDropdown(),
              const SizedBox(height: 40),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(
                  label: Text('Description'),
                  border: OutlineInputBorder(),
                ),
                minLines: 5,
                maxLines: 10,
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
