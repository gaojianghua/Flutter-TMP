/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-22 16:52:09
 * @LastEditors: 高江华
 * @LastEditTime: 2023-09-22 17:27:14
 * @Description: file content
 */
import 'package:dio/dio.dart';

class CustomDio {
  final Dio _dio = Dio();

  CustomDio() {
    _dio.options.baseUrl = 'https://gaojianghua.cn:8888/api';
    _dio.interceptors.add(CustomInterceptors());
  }

  Future<Response> get(String url, {Map<String, dynamic>? params}) async {
    return await _dio.get(url, queryParameters: params);
  }

  Future<Response> post(String url, {required dynamic data}) async {
    return await _dio.post(url, data: data);
  }

  Future<Response> put(String url, {required dynamic data}) async {
    return await _dio.put(url, data: data);
  }

  Future<Response> delete(String url, {Map<String, dynamic>? params}) async {
    return await _dio.delete(url, queryParameters: params);
  }

  Future<Response> uploadFile(String url, {required String path}) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(path),
    });
    return await _dio.post(url, data: formData);
  }
}

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('Request: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response: ${response.statusCode}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('Error: ${err.message}');
    return super.onError(err, handler);
  }
}