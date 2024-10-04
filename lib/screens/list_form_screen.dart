import 'package:dutask/data/list_icons.dart';
import 'package:dutask/models/list_model.dart';
import 'package:dutask/providers/lists_provider.dart';
import 'package:dutask/utils/extensions.dart';
import 'package:dutask/utils/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dutask/utils/constants.dart';

class ListFormScreen extends ConsumerStatefulWidget {
  const ListFormScreen({super.key, this.list});

  final ListModel? list;

  @override
  ConsumerState<ListFormScreen> createState() => _ListFormViewState();
}

class _ListFormViewState extends ConsumerState<ListFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  String _iconValue = "list";

  @override
  void initState() {
    super.initState();
    if (widget.list != null) {
      _titleTextController.text = widget.list!.title;
      if (widget.list!.description != null) {
        _descriptionTextController.text = widget.list!.description!;
      }
    }
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _descriptionTextController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String? snackBarMessage;
      final listNotifier = ref.read(listsProvider.notifier);

      if (widget.list != null) {
        listNotifier.updateList(
          widget.list!.id,
          widget.list!.copyWith(
              title: _titleTextController.text,
              icon: _iconValue,
              description: _descriptionTextController.text),
        );
        snackBarMessage = 'List updated successfully';
      } else {
        listNotifier.createList(
          ListModel(
              id: uuid.v4(),
              title: _titleTextController.text,
              icon: _iconValue,
              description: _descriptionTextController.text),
        );
        snackBarMessage = 'List created successfullly';
      }
      Navigator.of(context).pop();
      context.showListSnackBarWithUndo(listNotifier, snackBarMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.list == null ? 'New list' : widget.list!.title),
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
                    autofocus: widget.list == null,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Icon:",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 20),
                      DropdownButton<String>(
                        focusColor: Colors.transparent,
                        value: widget.list != null
                            ? widget.list!.icon
                            : _iconValue,
                        icon: Icon(iconMap[widget.list != null
                            ? widget.list!.icon
                            : _iconValue]),
                        elevation: 16,
                        onChanged: (String? value) {
                          setState(() {
                            _iconValue = value!;
                          });
                        },
                        selectedItemBuilder: (BuildContext context) {
                          return iconMap.keys.map<Widget>((String value) {
                            return Row(
                              children: [Text(value), SizedBox(width: 16)],
                            );
                          }).toList();
                        },
                        items: iconMap.keys
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text(value), Icon(iconMap[value])],
                            ),
                          );
                        }).toList(),
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
