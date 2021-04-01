import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'timeentry.g.dart';

@JsonSerializable()
class TimeEntry {
  int id;
  DateTime date;
  int minutes;
  String description;
  int issueId; // issueId
  int userId; // userId
  String issueName;
  String userName;

  TimeEntry({
    @required this.id,
    @required this.date,
    @required this.minutes,
    @required this.description,
    @required this.issueId,
    @required this.userId,
    @required this.issueName,
    @required this.userName,
  });

  factory TimeEntry.fromJson(Map<String, dynamic> json) => _$TimeEntryFromJson(json);
  Map<String, dynamic> toJson() => _$TimeEntryToJson(this);
}

@JsonSerializable()
class WorkTimeList {
  List<TimeEntry> worktimes;

  WorkTimeList(this.worktimes);

  factory WorkTimeList.fromJson(Map<String, dynamic> json) => _$WorkTimeListFromJson(json);
  Map<String, dynamic> toJson() => _$WorkTimeListToJson(this);
}
