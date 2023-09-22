/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 11:25:16
 * @LastEditors: 高江华
 * @LastEditTime: 2023-09-22 17:37:08
 * @Description: file content
 */
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/config/request/api/system.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _public = '';

  void getPublicKey () async {
    SystemApi systemApi = SystemApi();
    
    Response response = await systemApi.getPublicKey();
    setState(() {
      _public = response.data['data']['server_public_key'];
    });
    print('User: ${response.data}');
  }

  @override
  void initState() {
    getPublicKey();
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        child: Text('$_public'),
      ),
    );
  }
}
