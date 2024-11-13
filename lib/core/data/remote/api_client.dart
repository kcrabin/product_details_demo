import 'dart:io';

import 'package:dio/dio.dart';

class ApiClient {
  final String baseUrl;
  late Dio _dio;
  final Interceptor? interceptor;

  ApiClient({required this.baseUrl, required Dio dio, this.interceptor}) {
    _dio = dio;

    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = Duration(seconds: 10)
      ..options.receiveTimeout = Duration(seconds: 10)
      ..httpClientAdapter
      ..options.headers = {'Accept': 'application/json'};

    if (interceptor != null) {
      _dio.interceptors.clear();
      _dio.interceptors.add(interceptor!);
    }
  }

  Future<dynamic> get(
      String uri, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options ?? Options(headers: {"requiresToken": false}),
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
      String uri, {
        // ignore: type_annotate_public_apis
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(headers: {"requiresToken": false}),
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }


}
