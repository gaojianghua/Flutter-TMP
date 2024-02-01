/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-06 13:53:49
 * @LastEditors: 高江华
 * @LastEditTime: 2024-02-01 09:32:36
 * @Description: file content
 */
import 'package:flutter_shop/pages_offspring/goods_detail_page.dart';
import 'package:flutter_shop/pages_next/my/about_page.dart';
import 'package:flutter_shop/pages_next/my/settings_page.dart';
import 'package:flutter_shop/pages/tabbar/home_page.dart';
import 'package:get/get.dart';

import '../pages_next/home/news_page.dart';

List<GetPage<dynamic>>? routers = [
  GetPage(name: '/', page: () => HomePage()),
  GetPage(name: '/goods_detail', page: () => GoodsDetailPage()),
  GetPage(name: '/about', page: () => AboutPage()),
  GetPage(name: '/settings', page: () => SettingsPage()),
  GetPage(name: '/news', page: () => NewsPage()),
];

