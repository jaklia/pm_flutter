import 'package:pm_flutter/bloc/users/users_repository.dart';
import 'package:pm_flutter/models/user.dart';
import 'package:pm_flutter/models/worktime.dart';
import 'package:rxdart/subjects.dart';

class UsersBloc {
  final _repository = UsersRepository();
  final _users = BehaviorSubject<List<User>>.seeded([]);
  final _worktimes = BehaviorSubject<List<WorkTime>>.seeded([]);
  final _userWorktimes = BehaviorSubject<List<WorkTime>>.seeded([]);
  final _currentUser = BehaviorSubject<User>();

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
    final res = await _repository.getUserWorktimes(user.userId);
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
}
