import 'package:dutask/data/initial_lists.dart';
import 'package:dutask/models/list_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListsProvider extends Notifier<List<ListModel>> {
  List<ListModel> previousState = const [];

  @override
  build() {
    return _fetchLists();
  }

  void createList(ListModel list) {
    previousState = [...state];
    state = [...state, list];
  }

  void updateList(String listId, ListModel updatedList) {
    previousState = [...state];
    final localPreviousState = [...state];
    final listToReplaceIndex = state.indexWhere((list) => list.id == listId);
    if (listToReplaceIndex != -1) {
      localPreviousState[listToReplaceIndex] = updatedList;
      state = [...localPreviousState];
    }
  }

  void deleteList(String listId) {
    previousState = [...state];
    state = state.where((list) => list.id != listId).toList();
  }

  void undo() {
    final localPreviousState = [...state];
    state = [...previousState];
    previousState = [...localPreviousState];
  }

  List<ListModel> _fetchLists() {
    return initialLists;
  }
}

final listsProvider = NotifierProvider<ListsProvider, List<ListModel>>(
  ListsProvider.new,
);
