import 'package:pm_flutter/bloc/timeentries/timeentries_repository.dart';
import 'package:pm_flutter/models/timeentry.dart';
import 'package:rxdart/subjects.dart';

class TimeEntriesBloc {
  final _repository = TimeEntriesRepository();
  final _worktimes = BehaviorSubject<List<TimeEntry>>.seeded([]);

  get worktimes {
    return _worktimes.stream;
  }

  Future<void> getWorktimes(DateTime from, DateTime to) async {
    var res = await _repository.getWorktimes(from, to);
    _worktimes.sink.add(res);
  }

  Future<void> addWorktime(TimeEntry wt) async {
    var res = await _repository.addWorktime(wt);
    _worktimes.sink.add(_worktimes.value..add(res));
  }

  Future<void> editWorktime(TimeEntry wt) async {
    _repository.editWorktime(wt);
  }

  Future<void> deleteWorktime(TimeEntry wt) async {
    _repository.deleteWorktime(wt);
  }

  Future<void> filter(DateTime from, DateTime to) async {
    var res = await _repository.filter(from, to);
    _worktimes.sink.add(res);
  }

  void dispose() {
    _worktimes.close();
  }
}
