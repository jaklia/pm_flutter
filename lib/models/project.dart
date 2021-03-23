import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable()
class Project {
  int id;
  String name;
  String description;

  Project({
    @required this.id,
    @required this.name,
    @required this.description,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}

@JsonSerializable()
class ProjectList {
  List<Project> pojects;

  ProjectList(this.pojects);

  factory ProjectList.fromJson(Map<String, dynamic> json) =>
      _$ProjectListFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectListToJson(this);
}
