import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'worktime.g.dart';

@JsonSerializable()
class WorkTime {
  int id;
  DateTime date; //    [2019-11-25 00:00:00.000]    space előtti rész
  int duration;
  int issueId; // issueId
  String userId; // userId
  String issueName;

  WorkTime({
    @required this.id,
    @required this.date,
    @required this.duration,
    @required this.issueId,
    @required this.userId,
    @required this.issueName,
  });

  factory WorkTime.fromJson(Map<String, dynamic> json) =>
      _$WorkTimeFromJson(json);
  Map<String, dynamic> toJson() => _$WorkTimeToJson(this);
}

@JsonSerializable()
class WorkTimeList {
  List<WorkTime> worktimes;

  WorkTimeList(this.worktimes);

  factory WorkTimeList.fromJson(Map<String, dynamic> json) =>
      _$WorkTimeListFromJson(json);
  Map<String, dynamic> toJson() => _$WorkTimeListToJson(this);
}
