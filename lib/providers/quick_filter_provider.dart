import 'package:dutask/types/task_filter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterTypeProvider = StateProvider((ref) => TaskFilter.status);
