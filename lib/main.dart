/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 10:53:47
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-06 14:06:23
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/pages/common/not_found_page.dart';
import 'router/index.dart';
import 'package:get/get.dart';
import 'config/request/index.dart';
import 'pages/tabbar/index_page.dart';
import 'store/system_store.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  CustomDio();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '百姓生活',
      initialRoute: '/',
      getPages: routers,
      unknownRoute: GetPage(name: '/not-found', page: () => NotFoundPage()),
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: BlocProvider(
        create: (_)=> SystemStore(),
        child: const IndexPage()
      )
    );
  }
}