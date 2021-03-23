// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worktime.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkTime _$WorkTimeFromJson(Map<String, dynamic> json) {
  return WorkTime(
    id: json['id'] as int,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    duration: json['duration'] as int,
    issueId: json['issueId'] as int,
    userId: json['userId'] as String,
    issueName: json['issueName'] as String,
  );
}

Map<String, dynamic> _$WorkTimeToJson(WorkTime instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'duration': instance.duration,
      'issueId': instance.issueId,
      'userId': instance.userId,
      'issueName': instance.issueName,
    };

WorkTimeList _$WorkTimeListFromJson(Map<String, dynamic> json) {
  return WorkTimeList(
    (json['worktimes'] as List)
        ?.map((e) =>
            e == null ? null : WorkTime.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$WorkTimeListToJson(WorkTimeList instance) =>
    <String, dynamic>{
      'worktimes': instance.worktimes,
    };
