// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Issue _$IssueFromJson(Map<String, dynamic> json) {
  return Issue(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    projectId: json['projectId'] as int,
  );
}

Map<String, dynamic> _$IssueToJson(Issue instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'projectId': instance.projectId,
    };

IssueList _$IssueListFromJson(Map<String, dynamic> json) {
  return IssueList(
    (json['issues'] as List)
        ?.map(
            (e) => e == null ? null : Issue.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$IssueListToJson(IssueList instance) => <String, dynamic>{
      'issues': instance.issues,
    };
