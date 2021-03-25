import 'dart:convert';

import 'package:pm_flutter/models/user.dart';
import 'package:pm_flutter/utility/network.dart';
import 'package:pm_flutter/utility/urls.dart';

class ProfileProvider {
  Future<User> login(String userName, String password) async {
    // return Future.delayed(
    //   Duration(milliseconds: 500),
    //   () => User(
    //       name: email, role: Role.Admin, userId: 1, email: "test@test.hu"),
    // );

    var res =
        await Network.dio.post(Urls.LOGIN, data: {"username": userName, "password": password});

    // var asd = jsonDecode(res.data);
    var token = res.data["accessToken"];
    var user = User.fromJson(res.data["user"]);

    print(res.toString());

    return user;
  }

  logout() {
    //TODO: logout
  }
}
