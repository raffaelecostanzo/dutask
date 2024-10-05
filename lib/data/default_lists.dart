import 'package:dutask/models/list_model.dart';
import 'package:dutask/utils/constants.dart';

final defaultLists = [
  ListModel(
    title: 'My Day',
    description: 'Day to day lists.',
    icon: 'audiotrack',
    id: uuid.v4(),
  ),
  ListModel(
    title: 'Recurrences',
    description: 'Lists with a recurrence.',
    icon: 'favorite',
    id: uuid.v4(),
  ),
  ListModel(
    title: 'Important',
    description: 'Important lists.',
    icon: 'beach_access',
    id: uuid.v4(),
  ),
  ListModel(
    title: 'Gifts',
    description: 'Next gifts for my friends.',
    icon: 'audiotrack',
    id: uuid.v4(),
  ),
  ListModel(
    title: 'Food',
    description: 'Food I have to try.',
    icon: 'list',
    id: uuid.v4(),
  ),
  ListModel(
    title: 'Medicine',
    description: 'Medicines I need to take.',
    icon: 'account_circle',
    id: uuid.v4(),
  ),
  ListModel(
    title: 'Travels',
    description: 'Future Travels...',
    icon: 'settings',
    id: uuid.v4(),
  ),
  ListModel(
    title: 'Work',
    description: 'My work tasks.',
    icon: 'search',
    id: uuid.v4(),
  ),
  ListModel(
    title: 'Personal',
    description: 'The title says it all.',
    icon: 'home',
    id: uuid.v4(),
  ),
  ListModel(
    title: 'Absurdities',
    description: 'Is this real? Or am I too low for this?',
    icon: 'account_circle',
    id: uuid.v4(),
  ),
  ListModel(
    title: 'Music',
    description: 'Music I have to listen to.',
    icon: 'audiotrack',
    id: uuid.v4(),
  )
];
