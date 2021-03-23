import 'package:pm_flutter/mock/worktimes.dart';
import 'package:pm_flutter/models/worktime.dart';
import 'package:pm_flutter/utility/network.dart';
import 'package:pm_flutter/utility/urls.dart';

class WorktimesProvider {
  // TODO:    userId  +  duration
  Future<List<WorkTime>> getWorktimes(DateTime from, DateTime to) async {
    return Future.delayed(Duration(milliseconds: 500), () => worktimes);
    // var f = from.toString().split(" ");
    // var t = to.toString().split(" ");
    // var res = await Network.dio
    //     .get(Urls.WORKTIME, queryParameters: {"from": f[0], "to": t[0]});
    // print(res.data.toString());
    // List<WorkTime> list = res.data.map<WorkTime>(
    //   (item) {
    //     Map<String, dynamic> asd = item;
    //     print(asd);
    //     var x = WorkTime.fromJson(asd);
    //     return x;
    //   },
    // ).toList();
    // return list;
  }

  Future<WorkTime> addWorktime(WorkTime wt) async {
    var res = await Network.dio.post(Urls.WORKTIME, data: wt.toJson());
    return WorkTime.fromJson(res.data);
  }

  Future deleteWorktime(WorkTime wt) async {
    var res = await Network.dio.delete("${Urls.WORKTIME}/${wt.id}");
  }

  Future editWorktime(WorkTime wt) async {
    var res = await Network.dio.put("${Urls.WORKTIME}/${wt.id}");
  }

  Future<List<WorkTime>> filter(DateTime from, DateTime to) {
    return getWorktimes(from, to);
  }
}
