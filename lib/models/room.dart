import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room.g.dart';

@JsonSerializable(explicitToJson: true)
class Room {
  int id;
  String name;
  int capacity;

  Room({
    @required this.id,
    @required this.name,
    @required this.capacity,
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
  Map<String, dynamic> toJson() => _$RoomToJson(this);
}
