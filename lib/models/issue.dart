import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'issue.g.dart';

@JsonSerializable()
class Issue {
  int id;
  String subject;
  String description;
  DateTime startDate;
  DateTime dueDate;
  int estimatedHours;
  int projectId;

  Issue({
    @required this.id,
    @required this.subject,
    @required this.description,
    @required this.projectId,
    this.estimatedHours,
    this.startDate,
    this.dueDate,
  });

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);
  Map<String, dynamic> toJson() => _$IssueToJson(this);
}

@JsonSerializable()
class IssueList {
  List<Issue> issues;

  IssueList(this.issues);

  factory IssueList.fromJson(Map<String, dynamic> json) => _$IssueListFromJson(json);
  Map<String, dynamic> toJson() => _$IssueListToJson(this);
}
