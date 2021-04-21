import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave.g.dart';

@JsonSerializable()
class Leave {
  int id;
  DateTime startDate;
  DateTime endDate;
  bool approved;
  int userId;

  Leave({
    @required this.id,
    @required this.startDate,
    @required this.endDate,
    @required this.approved,
    @required this.userId,
  });

  factory Leave.fromJson(Map<String, dynamic> json) => _$LeaveFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveToJson(this);
}
