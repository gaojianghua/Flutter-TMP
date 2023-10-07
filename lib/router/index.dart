import 'package:flutter_shop/pages/my/about_page.dart';
import 'package:flutter_shop/pages/my/settings_page.dart';
import 'package:flutter_shop/pages/tabbar/home_page.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routers = [
  GetPage(name: '/', page: () => HomePage()),
  GetPage(name: '/about', page: () => AboutPage()),
  GetPage(name: '/settings', page: () => SettingsPage()),
];

