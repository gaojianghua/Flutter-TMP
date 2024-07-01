/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-22 16:53:40
 * @LastEditors: 高江华
 * @LastEditTime: 2023-09-22 17:23:13
 * @Description: file content
 */
import 'package:dio/dio.dart';
import 'package:flutter_tmp/config/request/index.dart';

class SystemApi {
  final CustomDio _dio = CustomDio();

  Future<Response> getPublicKey() {
    return _dio.post('/user/public/key', data: null);
  }

  Future<Response> updateUser(int id, Map<String, dynamic> data) {
    return _dio.put('/user/$id', data: data);
  }

  // 其他与用户相关的 API 请求方法...
}