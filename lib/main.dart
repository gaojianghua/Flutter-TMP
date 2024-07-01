/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-08 14:42:19
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-14 00:20:48
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/routes/app_pages.dart';

void main() {
  // 配置透明状态栏
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle();
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  runApp(ScreenUtilInit(
      designSize: const Size(1080, 2400), //设计稿的宽度和高度 px
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Application",
          theme: ThemeData(
            primarySwatch: Colors.grey
          ),
          initialRoute: AppPages.INITIAL,
          // 配置IOS动画
          defaultTransition: Transition.rightToLeft,
          getPages: AppPages.routes,
        );
      }));
}
