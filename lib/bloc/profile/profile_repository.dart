import 'package:pm_flutter/bloc/profile/profile_provider.dart';
import 'package:pm_flutter/local_store/shared_prefs_manager.dart';
import 'package:pm_flutter/models/user.dart';
import 'package:pm_flutter/utility/token_manager.dart';

class ProfileRepository {
  final _provider = ProfileProvider();

  Future<int> login(String email, String password) async {
    var token = await _provider.login(email, password);
    var success = await SharedPrefsManager.saveToken(token);
    var id = TokenManager.getUserId(token);
    // var user = await getProfile(id);
    // return user;
    return id;
  }

  Future<User> getProfile(int userId) => _provider.getProfile(userId);

  Future<void> logout() async {
    await _provider.logout();
    await SharedPrefsManager.removeToken();
  }
}
