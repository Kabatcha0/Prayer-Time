import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://api.aladhan.com/v1/calendarByCity/",
        receiveDataWhenStatusError: true));
  }

  static Future<Response> getData({
    required String path,
    required String city,
    required String country,
    required int method,
  }) async {
    return await dio.get(path,
        queryParameters: {"city": city, "country": country, "method": method});
  }
}
