import 'package:pm_flutter/bloc/profile/profile_provider.dart';
import 'package:pm_flutter/models/user.dart';

class ProfileRepository {
  final _provider = ProfileProvider();

  Future<User> login(String email, String password) =>
      _provider.login(email, password);

  logout() => _provider.logout();
}
