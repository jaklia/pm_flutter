import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:pm_flutter/local_store/shared_prefs_manager.dart';
import 'package:pm_flutter/utility/urls.dart';

class Network {
  Dio _dio;

  static init() async {}

  Network._privateConstructor() {
    if (_dio == null) {
      _dio = Dio(BaseOptions(baseUrl: Urls.BASEURL));
      _dio.interceptors.add(_interceptors);
      // this below is needed to fix bad certificate when accessing localhost
      //   it's probably only because of debug
      //     when app is published to azure, probably won't need it anymore
      //   or maybe because https is enabled, then no idea how to get a certificate
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  static final Network _instance = Network._privateConstructor();

  static Dio get dio {
    return _instance._dio;
  }

  var _interceptors = InterceptorsWrapper(onRequest: (RequestOptions options) async {
    // Do something before request is sent
    if (options.path != Urls.LOGIN) {
      // add token to header if not login
      var token = await SharedPrefsManager.getToken();
      var t = "Bearer $token";
      options.headers["Authorization"] = t;
      var asd = "asdasdasd";
    }
    return options;
  }, onResponse: (Response response) {
    // Do something with response data
    return response; // continue
  }, onError: (DioError error) async {
    // Do something with response error
    // if (error.response?.statusCode == 403) {
    //   _dio.interceptors.requestLock.lock();
    //   _dio.interceptors.responseLock.lock();
    //   RequestOptions options = error.response.request;
    //   FirebaseUser user = await FirebaseAuth.instance.currentUser();
    //   token = await user.getIdToken(refresh: true);
    //   await writeAuthKey(token);
    //   options.headers["Authorization"] = "Bearer " + token;

    //   _dio.interceptors.requestLock.unlock();
    //   _dio.interceptors.responseLock.unlock();
    //   return _dio.request(options.path, options: options);
    // } else {
    return error;
    // }
  });
}
