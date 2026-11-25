import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

/// Project fields exposed by the existing Django portfolio backend.
@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  const Project({
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    this.id,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;
  final String title;
  final String description;
  final String category;
  final String status;

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
