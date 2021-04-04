import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pm_flutter/models/room.dart';

part 'meeting.g.dart';

// Room _roomFromJson(Map<String, dynamic> json) => Room.fromJson(json);
// Map<String, dynamic> _roomToJson(Room room) => room.toJson();

@JsonSerializable(explicitToJson: true)
class Meeting {
  int id;
  String title;
  DateTime startDate;
  DateTime endDate;
  //@JsonKey(fromJson: _roomFromJson, toJson: _roomToJson)
  Room room;
  List<int> userIds;

  Meeting({
    @required this.id,
    @required this.startDate,
    @required this.endDate,
    @required this.room,
    @required this.userIds,
    @required this.title,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) => _$MeetingFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingToJson(this);
}
