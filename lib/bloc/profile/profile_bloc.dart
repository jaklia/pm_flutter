import 'package:pm_flutter/bloc/profile/profile_repository.dart';
import 'package:pm_flutter/models/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ProfileBloc {
  final _repository = ProfileRepository();
  final _profile = BehaviorSubject<User>();

  final _id = BehaviorSubject<int>();

  ValueObservable<User> get profile {
    return _profile.stream;
  }

  int get userId {
    return _id.value;
  }

  get isAdmin {
    return _profile.value.role == Role.Admin;
  }

  Future<bool> login(String email, String password) async {
    try {
      var res = await _repository.login(email, password);
      _id.sink.add(res);
      var user = await _repository.getProfile(userId);
      _profile.sink.add(user);

      return true;
    } catch (error) {
      print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXx");
      _id.sink.addError(error);
      return false;
    }
  }

  logout() {
    _repository.logout();
  }

  void dispose() {
    _profile.close();
    _id.close();
  }
}
