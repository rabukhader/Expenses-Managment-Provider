import 'package:dio/dio.dart';

import 'interceptor.dart';

class Client{
  Dio init() {
    Dio dio = Dio(
      BaseOptions(baseUrl: 'https://providerrest-default-rtdb.firebaseio.com' , contentType: 'application/json', headers: {'Accept': 'Application/json'})
    );
    dio.interceptors.add(ApiInterceptors());
    return dio;
  }
}