import 'package:pm_flutter/bloc/users/users_provider.dart';
import 'package:pm_flutter/models/user.dart';
import 'package:pm_flutter/models/timeentry.dart';

class UsersRepository {
  final _provider = UsersProvider();

  Future<List<User>> getUsersList(bool admin) => _provider.getUserList(admin);

  Future<List<TimeEntry>> getAllWorktimes() => _provider.getAllWorktimes();

  Future<List<TimeEntry>> getUserWorktimes(int userId) => _provider.getUserWorktimes(userId);
}
