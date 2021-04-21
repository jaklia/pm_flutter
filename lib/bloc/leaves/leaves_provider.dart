import 'package:pm_flutter/models/leave.dart';
import 'package:pm_flutter/utility/network.dart';
import 'package:pm_flutter/utility/urls.dart';

class LeavesProvider {
  Future<List<Leave>> getLeavesList() async {
    var res = await Network.dio.get(Urls.LEAVES);
    List<Leave> leaves = res.data.map<Leave>((json) => Leave.fromJson(json)).toList();
    return leaves;
  }

  Future<Leave> createLeave(Leave leave) async {
    var res = await Network.dio.post(
      Urls.LEAVES,
      data: leave.toJson(),
    );
    var newLeave = Leave.fromJson(res.data);
    return newLeave;
  }

  Future<void> updateLeave(Leave leave) async {
    await Network.dio.put(
      '${Urls.LEAVES}/${leave.id}',
      data: leave.toJson(),
    );
  }

  Future<void> deleteLeave(int id) async {
    await Network.dio.delete('${Urls.LEAVES}/$id');
  }
}
