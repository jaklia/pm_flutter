import 'package:pm_flutter/bloc/timeentries/timeentries_repository.dart';
import 'package:pm_flutter/models/timeentry.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class TimeEntriesBloc {
  final _repository = TimeEntriesRepository();
  final _timeEntries = BehaviorSubject<List<TimeEntry>>.seeded([]);

  ValueObservable<List<TimeEntry>> get timeEntries {
    return _timeEntries.stream;
  }

  Future<void> getWorktimes(DateTime from, DateTime to) async {
    var res = await _repository.getWorktimes(from, to);
    _timeEntries.sink.add(res);
  }

  Future<void> addWorktime(TimeEntry wt) async {
    var res = await _repository.addWorktime(wt);
    var newList = List<TimeEntry>.from(_timeEntries.value);
    newList.add(res);
    _timeEntries.sink.add(newList);
  }

  Future<void> editWorktime(TimeEntry wt) async {
    await _repository.editWorktime(wt);
    var newList = List<TimeEntry>.from(_timeEntries.value);
    var idx = newList.indexWhere((item) => item.id == wt.id);
    newList.replaceRange(idx, idx + 1, [wt]);
    _timeEntries.sink.add(newList);
  }

  Future<void> deleteWorktime(TimeEntry wt) async {
    await _repository.deleteWorktime(wt);
    var newList = List<TimeEntry>.from(_timeEntries.value);
    newList.removeWhere((element) => element.id == wt.id);
    _timeEntries.sink.add(newList);
  }

  Future<void> filter(DateTime from, DateTime to) async {
    var res = await _repository.filter(from, to);
    _timeEntries.sink.add(res);
  }

  void dispose() {
    _timeEntries.close();
  }
}
