/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 11:25:16
 * @LastEditors: 高江华
 * @LastEditTime: 2023-09-21 16:36:24
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    getHttp();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(),
    );
  }
  
  void getHttp() async {
    var appResponse = await post("/user/public/key");
    appResponse.when(success: (dynamic) {
      // var size = model.data?.length;
      debugPrint("成功返回$dynamic");
    }, failure: (String msg, int code) {
      debugPrint("失败了：msg=$msg/code=$code");
    });
  }
}
