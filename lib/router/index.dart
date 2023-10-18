/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-06 13:53:49
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-18 09:28:11
 * @Description: file content
 */
import 'package:flutter_shop/pages/common/goods_detail_page.dart';
import 'package:flutter_shop/pages/my/about_page.dart';
import 'package:flutter_shop/pages/my/settings_page.dart';
import 'package:flutter_shop/pages/tabbar/home_page.dart';
import 'package:get/get.dart';

import '../pages/home/news_page.dart';

List<GetPage<dynamic>>? routers = [
  GetPage(name: '/', page: () => HomePage()),
  GetPage(name: '/goods_detail', page: () => GoodsDetailPage()),
  GetPage(name: '/about', page: () => AboutPage()),
  GetPage(name: '/settings', page: () => SettingsPage()),
  GetPage(name: '/news', page: () => NewsPage()),
];

