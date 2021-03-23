// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return Project(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };

ProjectList _$ProjectListFromJson(Map<String, dynamic> json) {
  return ProjectList(
    (json['pojects'] as List)
        ?.map((e) =>
            e == null ? null : Project.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProjectListToJson(ProjectList instance) =>
    <String, dynamic>{
      'pojects': instance.pojects,
    };
