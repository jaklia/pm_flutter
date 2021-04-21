import 'package:pm_flutter/mock/worktimes.dart';
import 'package:pm_flutter/models/timeentry.dart';
import 'package:pm_flutter/utility/network.dart';
import 'package:pm_flutter/utility/urls.dart';

class TimeEntriesProvider {
  // TODO:    userId  +  duration
  Future<List<TimeEntry>> getWorktimes(DateTime from, DateTime to) async {
    //    return Future.delayed(Duration(milliseconds: 500), () => worktimes);
    // var f = from.toString().split(" ");
    // var t = to.toString().split(" ");
    // var res = await Network.dio
    //     .get(Urls.WORKTIME, queryParameters: {"from": f[0], "to": t[0]});
    var userId = 1;
    var res = await Network.dio.get('${Urls.USERS}/$userId/timeentries');
    print(res.data.toString());
    List<TimeEntry> list = res.data.map<TimeEntry>(
      (item) {
        Map<String, dynamic> asd = item;
        print(asd);
        var x = TimeEntry.fromJson(asd);
        return x;
      },
    ).toList();
    return list;
  }

  Future<TimeEntry> addTimeEntry(TimeEntry wt) async {
    var res = await Network.dio.post(Urls.TIMEENTRY, data: wt.toJson());
    return TimeEntry.fromJson(res.data);
  }

  Future deleteWorktime(TimeEntry wt) async {
    var res = await Network.dio.delete("${Urls.TIMEENTRY}/${wt.id}");
  }

  Future editWorktime(TimeEntry wt) async {
    var res = await Network.dio.put("${Urls.TIMEENTRY}/${wt.id}", data: wt.toJson());
  }

  Future<List<TimeEntry>> filter(DateTime from, DateTime to) {
    return getWorktimes(from, to);
  }
}
