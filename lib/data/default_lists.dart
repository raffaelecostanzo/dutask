import 'package:dutask/models/list_model.dart';

final defaultLists = [
  ListModel(
    title: 'My Day',
    description: 'Day to day lists.',
    icon: "audiotrack",
    id: uuid.v4(),
  ),
  ListModel(
    title: 'Recurrences',
    description: 'Lists with a recurrence.',
    icon: "favorite",
    id: uuid.v4(),
  ),
  ListModel(
    title: 'Important',
    description: 'Important lists.',
    icon: "beach_access",
    id: uuid.v4(),
  )
];
