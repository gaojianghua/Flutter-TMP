/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 11:25:45
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-18 09:27:34
 * @Description: file content
 */
import 'package:flutter/material.dart';


class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('个人中心'),
      ),
      body: Container(),
    );
  }
}