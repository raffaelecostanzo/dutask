import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String title,
    required DateTime? dueDate,
    required TaskStatus status,
    required String? description,
    required String? listId,
    required String id,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, Object> json) =>
      _$TaskModelFromJson(json);
}

enum TaskStatus { active, started, completed }
