import 'package:dio/dio.dart';

const baseUrl = String.fromEnvironment('BASE_URL', defaultValue: 'http://default-url');

final dio = Dio(
  BaseOptions(
    baseUrl: baseUrl,
    contentType: "application/json; charset=utf-8",
    validateStatus: (status) => true,
  ),
);
