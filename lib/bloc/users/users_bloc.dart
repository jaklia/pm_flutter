import 'package:pm_flutter/bloc/users/users_repository.dart';
import 'package:pm_flutter/models/user.dart';
import 'package:pm_flutter/models/timeentry.dart';
import 'package:rxdart/subjects.dart';

class UsersBloc {
  final _repository = UsersRepository();
  final _users = BehaviorSubject<List<User>>.seeded([]);
  final _worktimes = BehaviorSubject<List<TimeEntry>>.seeded([]);
  final _userWorktimes = BehaviorSubject<List<TimeEntry>>.seeded([]);
  final _currentUser = BehaviorSubject<User>();

  List<User> _filter = [];

  void dispose() {
    _users.close();
    _worktimes.close();
    _userWorktimes.close();
    _currentUser.close();
  }

  Future<void> getUsersList(bool admin) async {
    final res = await _repository.getUsersList(admin);
    _users.sink.add(res);
  }

  Future<void> getAllWorktimes() async {
    final res = await _repository.getAllWorktimes();
    _worktimes.sink.add(res);
  }

  Future<void> getUserWorktimes(User user) async {
    final res = await _repository.getUserWorktimes(user.id);
    _userWorktimes.sink.add(res);
    _currentUser.sink.add(user);
  }

  get users {
    return _users.stream;
  }

  get allWorktimes {
    return _worktimes.stream;
  }

  get userWorktimes {
    return _userWorktimes.stream;
  }

  List<User> get filteredUsers {
    var newList = _users.value;
    for (var u in _filter) {
      newList.removeWhere((item) => item.id == u.id);
    }
    return newList;
  }

  void setFilter(List<User> filter) {
    _filter = filter;
  }
}
