// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meeting _$MeetingFromJson(Map<String, dynamic> json) {
  return Meeting(
    id: json['id'] as int,
    title: json['title'] as String,
    startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate'] as String),
    endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate'] as String),
    room: json['room'] == null ? null : Room.fromJson(json['room'] as Map<String, dynamic>),
    userIds: (json['userIds'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$MeetingToJson(Meeting instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'room': instance.room?.toJson(),
      'userIds': instance.userIds,
    };
