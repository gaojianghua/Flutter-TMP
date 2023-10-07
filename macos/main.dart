/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 10:53:47
 * @LastEditors: 高江华
 * @LastEditTime: 2023-09-22 09:53:44
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'package:flutter_shop/config/request/index.dart';
import '../lib/pages/tabbar/index_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CustomDio();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {// 在这里添加netOptions变量的声明

  const MyApp({Key? key}) : super(key: key); // 修改构造函数

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '百姓生活',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const IndexPage(),
    );
  }
}