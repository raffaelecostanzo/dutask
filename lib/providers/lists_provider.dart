import 'package:dutask/data/default_lists.dart';
import 'package:dutask/models/list_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListsNotifier extends Notifier<List<ListModel>> {
  List<ListModel> _fetchLists() {
    return defaultLists;
  }

  @override
  build() {
    return _fetchLists();
  }

  late List<ListModel> previousState;

  void createList(ListModel list) {
    previousState = [...state];
    state = [...state, list];
  }

  void updateList(String listId, ListModel updatedList) {
    previousState = [...state];
    final localPreviousState = [...state];
    final listToReplaceIndex = state.indexWhere((list) => list.id == listId);
    localPreviousState[listToReplaceIndex] = updatedList;
    state = [...localPreviousState];
  }

  void deleteList(String listId) {
    previousState = [...state];
    state = [...state.where((list) => list.id != listId)];
  }

  void undo() {
    final localPreviousState = [...state];
    state = [...previousState];
    previousState = [...localPreviousState];
  }
}

final listsProvider = NotifierProvider<ListsNotifier, List<ListModel>>(
  ListsNotifier.new,
);
