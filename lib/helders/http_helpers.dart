import 'package:dio/dio.dart';

import 'constants.dart';

Dio makeDefaultDio() {
  return Dio(
    BaseOptions(baseUrl: 'http://localhost:8000/api', headers: {
      'Authorization': 'Bearer $authToken',
      Headers.contentTypeHeader: Headers.jsonContentType,
    }),
  );
}
