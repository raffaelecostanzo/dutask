import 'package:uuid/uuid.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

const uuid = Uuid();

enum TaskStatus { active, started, completed }

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String title,
    required String? description,
    required DateTime dueDate,
    required TaskStatus status,
    required String id,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, Object> json) =>
      _$TaskModelFromJson(json);
}
