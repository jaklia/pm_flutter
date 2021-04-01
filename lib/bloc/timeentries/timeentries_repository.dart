import 'package:pm_flutter/bloc/timeentries/timeentries_provider.dart';
import 'package:pm_flutter/models/timeentry.dart';

class TimeEntriesRepository {
  final _provider = TimeEntriesProvider();
  List<TimeEntry> wts;

  Future<List<TimeEntry>> getWorktimes(DateTime from, DateTime to) =>
      _provider.getWorktimes(from, to);

  Future<TimeEntry> addWorktime(TimeEntry wt) => _provider.addWorktime(wt);

  Future<void> deleteWorktime(TimeEntry wt) => _provider.deleteWorktime(wt);

  Future<void> editWorktime(TimeEntry wt) => _provider.editWorktime(wt);

  Future filter(DateTime from, DateTime to) => _provider.filter(from, to);
}
