// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeentry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeEntry _$TimeEntryFromJson(Map<String, dynamic> json) {
  return TimeEntry(
    id: json['id'] as int,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    minutes: json['minutes'] as int,
    description: json['description'] as String,
    issueId: json['issueId'] as int,
    userId: json['userId'] as int,
    issueName: json['issueName'] as String,
    userName: json['userName'] as String,
  );
}

Map<String, dynamic> _$TimeEntryToJson(TimeEntry instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'minutes': instance.minutes,
      'description': instance.description,
      'issueId': instance.issueId,
      'userId': instance.userId,
      'issueName': instance.issueName,
      'userName': instance.userName,
    };

WorkTimeList _$WorkTimeListFromJson(Map<String, dynamic> json) {
  return WorkTimeList(
    (json['worktimes'] as List)
        ?.map((e) => e == null ? null : TimeEntry.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$WorkTimeListToJson(WorkTimeList instance) => <String, dynamic>{
      'worktimes': instance.worktimes,
    };
