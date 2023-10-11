/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-06 13:53:49
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-11 13:51:46
 * @Description: file content
 */
import 'package:flutter_shop/pages/common/goods_detail_page.dart';
import 'package:flutter_shop/pages/my/about_page.dart';
import 'package:flutter_shop/pages/my/settings_page.dart';
import 'package:flutter_shop/pages/tabbar/home_page.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routers = [
  GetPage(name: '/', page: () => HomePage()),
  GetPage(name: '/goods_detail', page: () => GoodsDetailPage()),
  GetPage(name: '/about', page: () => AboutPage()),
  GetPage(name: '/settings', page: () => SettingsPage()),
];

