import 'dart:async';

import 'package:pm_flutter/bloc/meeting/meeting_repository.dart';
import 'package:pm_flutter/helper/date.dart';
import 'package:pm_flutter/models/meeting.dart';
import 'package:rxdart/rxdart.dart';

class MeetingsBloc {
  final _repository = MeetingRepository();
  final _meetings = BehaviorSubject<List<Meeting>>.seeded([]);

  ValueObservable<List<Meeting>> get meetings {
    return _meetings.stream;
  }

  Map<DateTime, List<Meeting>> tr(List<Meeting> meetingList) {
    var byDate = Map<DateTime, List<Meeting>>();

    for (var m in meetingList) {
      var date = m.startDate.onlyDate();
      if (!byDate.containsKey(date)) {
        byDate[date] = [];
      }
      byDate[date].add(m);
    }
    return byDate;
  }

  Map<DateTime, List<Meeting>> get meetingMap {
    var byDate = Map<DateTime, List<Meeting>>();
    if (!_meetings.hasValue) {
      return {};
    }

    for (var m in _meetings.value) {
      var date = m.startDate.onlyDate();
      if (!byDate.containsKey(date)) {
        byDate[date] = [];
      }
      byDate[date].add(m);
    }
    return byDate;
  }

  // get asd {
  //   return _meetings.map((value) {
  //     var byDate = Map<DateTime, List<Meeting>>();

  //     for (var m in value) {
  //       var date = m.startDate.onlyDate();
  //       if (!byDate.containsKey(date)) {
  //         byDate[date] = [];
  //       }
  //       byDate[date].add(m);
  //     }
  //     return byDate;
  //   });
  // }

  Future<void> getMeetings() async {
    var newList = await _repository.getMeetings();
    _meetings.sink.add(newList);
  }

  Future<void> getMeeting(int id) async {
    // TODO:   get a single meeting
  }

  Future<void> createMeeting(Meeting meeting) async {
    var m = await _repository.createMeeting(meeting);
    var newList = List<Meeting>.from(_meetings.value);
    newList.add(m);
    _meetings.sink.add(newList);
  }

  Future<void> updateMeeting(Meeting meeting) async {
    await _repository.updateMeeting(meeting);
    var newList = List<Meeting>.from(_meetings.value);
    var idx = newList.indexWhere((element) => element.id == meeting.id);
    newList.replaceRange(idx, idx + 1, [meeting]);
    _meetings.sink.add(newList);
  }

  Future<void> deleteMeeting(int id) async {
    await _repository.deleteMeeting(id);
    var newList = List<Meeting>.from(_meetings.value);
    newList.removeWhere((element) => element.id == id);
    _meetings.sink.add(newList);
  }

  void dispose() {
    _meetings.close();
  }
}
