import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_model.freezed.dart';
part 'list_model.g.dart';

@freezed
class ListModel with _$ListModel {
  const factory ListModel({
    required String title,
    required String icon,
    required String? description,
    required String id,
  }) = _ListModel;

  factory ListModel.fromJson(Map<String, Object> json) =>
      _$ListModelFromJson(json);
}
