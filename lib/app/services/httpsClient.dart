/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-13 14:52:48
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-22 10:15:27
 * @Description: file content
 */
import 'package:dio/dio.dart';

class HttpsClient {
  static String domain = "https://miapp.itying.com/";
  static Dio dio = Dio();
  HttpsClient() {
    dio.options.baseUrl = domain;
    // dio.options.connectTimeout = 5000 as Duration; //5s
    // dio.options.receiveTimeout = 5000 as Duration;
  }

  Future get(apiUrl) async {
    try {
      var response = await dio.get(apiUrl);
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future post(String apiUrl,{Map? data}) async {   
    try {
      var response = await dio.post(apiUrl,data:data);
      return response;
    } catch (e) {
      print("请求超时");
      return null;
    }
  }

  static replaceUri(picUrl) {
    String tempUrl = domain + picUrl;
    return tempUrl.replaceAll("\\", "/");
  }
}
