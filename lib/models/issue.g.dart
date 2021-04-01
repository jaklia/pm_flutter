// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Issue _$IssueFromJson(Map<String, dynamic> json) {
  return Issue(
    id: json['id'] as int,
    subject: json['subject'] as String,
    description: json['description'] as String,
    projectId: json['projectId'] as int,
    estimatedHours: json['estimatedHours'] as int,
    startDate: json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String),
    dueDate: json['dueDate'] == null
        ? null
        : DateTime.parse(json['dueDate'] as String),
  );
}

Map<String, dynamic> _$IssueToJson(Issue instance) => <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'description': instance.description,
      'startDate': instance.startDate?.toIso8601String(),
      'dueDate': instance.dueDate?.toIso8601String(),
      'estimatedHours': instance.estimatedHours,
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
