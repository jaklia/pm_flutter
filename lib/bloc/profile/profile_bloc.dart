import 'package:pm_flutter/bloc/profile/profile_repository.dart';
import 'package:pm_flutter/models/user.dart';
import 'package:rxdart/subjects.dart';

class ProfileBloc {
  final _repository = ProfileRepository();

  final _profile = BehaviorSubject<User>();

  get profile {
    return _profile.stream;
  }

  get userId {
    return _profile.value.userId;
  }

  get isAdmin {
    return _profile.value.role == Role.Admin;
  }

  Future<bool> login(String email, String password) async {
    // try {
    var res = await _repository.login(email, password);
    _profile.sink.add(res);
    return true;
    // } catch (e) {
    //   return false;
    // }
  }

  logout() {
    _repository.logout();
  }

  void dispose() {
    _profile.close();
  }
}
