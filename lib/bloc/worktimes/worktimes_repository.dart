import 'package:pm_flutter/bloc/worktimes/worktimes_provider.dart';
import 'package:pm_flutter/models/worktime.dart';

class WorktimesRepository {
  final _provider = WorktimesProvider();
  List<WorkTime> wts;

  Future<List<WorkTime>> getWorktimes(DateTime from, DateTime to) =>
      _provider.getWorktimes(from, to);

  Future<WorkTime> addWorktime(WorkTime wt) => _provider.addWorktime(wt);

  Future<void> deleteWorktime(WorkTime wt) => _provider.deleteWorktime(wt);

  Future<void> editWorktime(WorkTime wt) => _provider.editWorktime(wt);

  Future filter(DateTime from, DateTime to) => _provider.filter(from, to);
}
