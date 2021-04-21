import 'package:pm_flutter/bloc/leaves/leaves_repository.dart';
import 'package:pm_flutter/models/leave.dart';
import 'package:rxdart/rxdart.dart';

class LeavesBloc {
  final _repository = LeavesRepository();
  final _leaves = BehaviorSubject<List<Leave>>.seeded([]);

  ValueObservable<List<Leave>> get leaves {
    return _leaves.stream;
  }

  Future<void> getLeaves() async {
    var newList = await _repository.getLeaves();
    _leaves.sink.add(newList);
  }

  Future<void> createLeave(Leave leave) async {
    var newLeave = await _repository.createLeave(leave);
    var newList = List<Leave>.from({..._leaves.value, newLeave});
    _leaves.sink.add(newList);
  }

  Future<void> updateLeave(Leave leave) async {
    await _repository.updateLeave(leave);
    var newList = List<Leave>.from(_leaves.value);
    var idx = newList.indexWhere((element) => element.id == leave.id);
    newList.replaceRange(idx, idx + 1, [leave]);
    _leaves.sink.add(newList);
  }

  Future<void> deleteLeave(int id) async {
    await _repository.deleteLeave(id);
    var newList = List<Leave>.from(_leaves.value);
    newList.removeWhere((element) => element.id == id);
    _leaves.sink.add(newList);
  }

  void dispose() {
    _leaves.close();
  }
}
