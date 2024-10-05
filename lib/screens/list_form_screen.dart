import 'package:dutask/data/list_icons.dart';
import 'package:dutask/models/list_model.dart';
import 'package:dutask/providers/lists_provider.dart';
import 'package:dutask/utils/extensions/common_extensions.dart';
import 'package:dutask/utils/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class ListFormScreen extends ConsumerStatefulWidget {
  const ListFormScreen({super.key, this.list});

  final ListModel? list;

  @override
  ConsumerState<ListFormScreen> createState() => _ListFormViewState();
}

class _ListFormViewState extends ConsumerState<ListFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final Uuid uuid = Uuid();

  String _screenTitle = "New list";
  String _title = '';
  String _description = '';
  String _icon = 'list';

  @override
  void initState() {
    super.initState();
    if (widget.list != null) {
      _screenTitle = widget.list!.title;
      _title = widget.list!.title;
      _description = widget.list!.description ?? '';
      _icon = widget.list!.icon;
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String snackBarMessage;
      final listNotifier = ref.read(listsProvider.notifier);

      if (widget.list != null) {
        listNotifier.updateList(
          widget.list!.id,
          widget.list!.copyWith(
            title: _title,
            icon: _icon,
            description: _description,
          ),
        );
        snackBarMessage = 'List updated successfully';
      } else {
        listNotifier.createList(
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
      context.showSnackBarWithUndo(listNotifier.undo, snackBarMessage);
    }
  }

  Widget _buildIconDropdown() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Icon:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 20),
        DropdownButton<String>(
          focusColor: Colors.transparent,
          value: _icon,
          icon: Icon(iconMap[_icon]),
          elevation: 16,
          onChanged: (value) {
            setState(() {
              _icon = value!;
            });
          },
          selectedItemBuilder: (BuildContext context) {
            return iconMap.keys.map<Widget>((String value) {
              return Row(
                children: [Text(value), const SizedBox(width: 16)],
              );
            }).toList();
          },
          items: iconMap.keys.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(value), Icon(iconMap[value])],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screenTitle),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Form(
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
                const SizedBox(height: 20),
                TextFormField(
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
