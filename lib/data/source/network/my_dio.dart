import 'package:dio/dio.dart';

import '../../../constants/constant_methods.dart';

class MyDio {
  late Dio dio;

  MyDio() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: '',
      receiveDataWhenStatusError: true,
      connectTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000,
    );
    dio = Dio(baseOptions);
    printTest('dio');
  }
}
