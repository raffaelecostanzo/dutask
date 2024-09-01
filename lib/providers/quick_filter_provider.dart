import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedQuickFilter = StateProvider((ref) => TaskStatusFilter);
