import 'package:dio/dio.dart';
export 'package:dio/dio.dart';
class NetWork {
  static final NetWork _singleton = new NetWork._internal();

  Dio dio;

  factory NetWork() {
    return _singleton;
  }

  NetWork._internal() {
    // initialization logic here
    dio = new Dio(Options(baseUrl: 'http://www.coinseast.com'));
  }
}
