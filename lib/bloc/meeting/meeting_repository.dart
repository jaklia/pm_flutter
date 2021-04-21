import 'package:pm_flutter/bloc/meeting/meeting_provider.dart';
import 'package:pm_flutter/models/meeting.dart';

class MeetingRepository {
  final _provider = MeetingProvider();

  Future<List<Meeting>> getMeetings() async => await _provider.getMeetingList();

  Future<Meeting> getMeeting(int id) async => await _provider.getMeeting(id);

  Future<Meeting> createMeeting(Meeting meeting) async => await _provider.createMeeting(meeting);

  Future<void> updateMeeting(Meeting meeting) async => await _provider.updateMeeting(meeting);

  Future<void> deleteMeeting(int id) async => await _provider.deleteMeeting(id);
}
