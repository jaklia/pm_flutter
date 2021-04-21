import 'package:pm_flutter/models/meeting.dart';
import 'package:pm_flutter/utility/network.dart';
import 'package:pm_flutter/utility/urls.dart';

class MeetingProvider {
  Future<List<Meeting>> getMeetingList() async {
    var res = await Network.dio.get(Urls.MEETING);
    List<Meeting> meetings = res.data
        .map<Meeting>(
          (json) => Meeting.fromJson(json),
        )
        .toList();
    return meetings;
  }

  Future<Meeting> getMeeting(int id) async {
    var res = await Network.dio.get('${Urls.MEETING}/$id');
    Meeting meeting = Meeting.fromJson(res.data);
    return meeting;
  }

  Future<Meeting> createMeeting(Meeting meeting) async {
    var res = await Network.dio.post(
      Urls.MEETING,
      data: meeting.toJson(),
    );
    var newMeeting = Meeting.fromJson(res.data);
    return newMeeting;
  }

  Future<void> updateMeeting(Meeting meeting) async {
    await Network.dio.put(
      '${Urls.MEETING}/${meeting.id}',
      data: meeting.toJson(),
    );
  }

  Future<void> deleteMeeting(int id) async {
    await Network.dio.delete('${Urls.MEETING}/$id');
  }
}
