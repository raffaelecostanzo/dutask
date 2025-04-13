import 'package:dutask/models/list_model.dart';
import 'package:dutask/utils/constants.dart';

final initialLists = [
  ListModel(
    title: 'My Day',
    description: 'Day to day lists.',
    icon: 'audiotrack',
    id: kUuid.v4(),
  ),
  ListModel(
    title: 'Recurrences',
    description: 'Lists with a recurrence.',
    icon: 'favorite',
    id: kUuid.v4(),
  ),
  ListModel(
    title: 'Important',
    description: 'Important lists.',
    icon: 'people',
    id: kUuid.v4(),
  ),
  ListModel(
    title: 'Gifts',
    description: 'Next gifts for my friends.',
    icon: 'audiotrack',
    id: kUuid.v4(),
  ),
  ListModel(
    title: 'Food',
    description: 'Food I have to try.',
    icon: 'park',
    id: kUuid.v4(),
  ),
  ListModel(
    title: 'Medicine',
    description: 'Medicines I need to take.',
    icon: 'people',
    id: kUuid.v4(),
  ),
  ListModel(
    title: 'Travels',
    description: 'Future Travels...',
    icon: 'settings',
    id: kUuid.v4(),
  ),
  ListModel(
    title: 'Work',
    description: 'My work tasks.',
    icon: 'search',
    id: kUuid.v4(),
  ),
  ListModel(
    title: 'Personal',
    description: 'The title says it all.',
    icon: 'home',
    id: kUuid.v4(),
  ),
  ListModel(
    title: 'Absurdities',
    description: 'Is this real? Or am I too low for this?',
    icon: 'people',
    id: kUuid.v4(),
  ),
  ListModel(
    title: 'Music',
    description: 'Music I have to listen to.',
    icon: 'audiotrack',
    id: kUuid.v4(),
  )
];
