import 'package:pm_flutter/bloc/worktimes/worktimes_repository.dart';
import 'package:pm_flutter/models/worktime.dart';
import 'package:rxdart/subjects.dart';

class WorktimesBloc {
  final _repository = WorktimesRepository();
  final _worktimes = BehaviorSubject<List<WorkTime>>.seeded([]);

  get worktimes {
    return _worktimes.stream;
  }

  Future<void> getWorktimes(DateTime from, DateTime to) async {
    var res = await _repository.getWorktimes(from, to);
    _worktimes.sink.add(res);
  }

  Future<void> addWorktime(WorkTime wt) async {
    var res = await _repository.addWorktime(wt);
    _worktimes.sink.add(_worktimes.value..add(res));
  }

  Future<void> editWorktime(WorkTime wt) async {
    _repository.editWorktime(wt);
  }

  Future<void> deleteWorktime(WorkTime wt) async {
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
