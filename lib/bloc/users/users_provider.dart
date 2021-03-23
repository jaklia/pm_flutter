import 'package:pm_flutter/mock/users.dart';
import 'package:pm_flutter/models/user.dart';
import 'package:pm_flutter/models/worktime.dart';
import 'package:pm_flutter/utility/network.dart';
import 'package:pm_flutter/utility/urls.dart';

class UsersProvider {
  Future<List<User>> getUserList(bool admin) async {
    return mockUsers;

    // var res = await Network.dio.get(Urls.USERS);
    // print(res.data.toString());
    // //var tmp = jsonDecode(res.data);
    // List<User> list = res.data.map<User>(
    //   (item) {
    //     Map<String, dynamic> asd = item;
    //     print(asd);
    //     var x = User.fromJson(asd);

    //     return x;
    //   },
    // ).toList();
    // return list;
  }

  Future<List<WorkTime>> getAllWorktimes() async {
    return [];
    // var res = await Network.dio.get(Urls.ADMIN);
    // print(res.data.toString());
    // List<WorkTime> list = res.data.map<WorkTime>(
    //   (item) {
    //     Map<String, dynamic> asd = item;
    //     print(asd);
    //     var x = WorkTime.fromJson(asd);
    //     return x;
    //   },
    // ).toList();
    // return list;
  }

  Future<List<WorkTime>> getUserWorktimes(String userId) async {
    return [];
    // var res = await Network.dio.get("${Urls.ADMIN}/$userId");
    // print(res.data.toString());
    // List<WorkTime> list = res.data.map<WorkTime>(
    //   (item) {
    //     Map<String, dynamic> asd = item;
    //     print(asd);
    //     var x = WorkTime.fromJson(asd);
    //     return x;
    //   },
    // ).toList();
    // return list;
  }
}
