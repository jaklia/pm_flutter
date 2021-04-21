import 'package:pm_flutter/bloc/leaves/leaves_provider.dart';
import 'package:pm_flutter/models/leave.dart';

class LeavesRepository {
  final _provider = LeavesProvider();

  Future<List<Leave>> getLeaves() async => await _provider.getLeavesList();

  Future<Leave> createLeave(Leave leave) async => await _provider.createLeave(leave);

  Future<void> updateLeave(Leave leave) async => await _provider.updateLeave(leave);

  Future<void> deleteLeave(int id) async => await _provider.deleteLeave(id);
}
