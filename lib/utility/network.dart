import 'package:dio/dio.dart';
import 'package:pm_flutter/utility/urls.dart';

class Network {
  Dio _dio;

  static init() async {}

  Network._privateConstructor() {
    if (_dio == null) {
      _dio = Dio(BaseOptions(baseUrl: Urls.BASEURL));
    }
  }

  static final Network _instance = Network._privateConstructor();

  static Dio get dio {
    return _instance._dio;
  }

  static void deleteCookies() {}

  // static String get cookies {
  //   return _instance._cookieJar
  //           .loadForRequest(Uri.parse(Urls.BASEURL + Urls.PROJECT))
  //           .toString() +
  //       "\n----------------\n" +
  //       _instance._cookieJar
  //           .loadForRequest(Uri.parse(Urls.BASEURL + Urls.LOGIN))
  //           .toString();
  // }

  // Future<Map<String, dynamic>> get(String url) async {
  //   var res = await dio.get(url);
  //   var data = res.data;
  //   var cookie = res.headers['set-cookie'];
  //   var x = jsonDecode(data);
  //   var asd = Map<String, dynamic>();
  //   asd = {'name': 'name', 'a': 1};
  //   return asd;
  // }

  // Future<Map<String, dynamic>> post(
  //     String url, Map<String, dynamic> body) async {
  //   var res = await dio.post(url, data: body);
  //   var asd = Map<String, dynamic>();
  //   asd = {'name': 'name', 'a': 1};
  //   return asd;
  // }

  // Map<String, dynamic> put(String url, Map<String, dynamic> body) {
  //   //
  // }

  // Map<String, dynamic> delete(String url, Map<String, dynamic> body) {
  //   //
  // }
}
