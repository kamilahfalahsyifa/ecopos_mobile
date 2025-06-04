import 'package:dio/dio.dart';

class DioProvider {
  static Dio createDioWithoutHeader() {
    Dio dio = Dio(BaseOptions(
      baseUrl: "https://tannn.my.id/api",
      ));
      
    return dio;
  } 
}
