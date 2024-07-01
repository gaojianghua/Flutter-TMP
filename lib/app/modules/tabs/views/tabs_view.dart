/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-08 11:25:45
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-08 14:26:07
 * @Description: file content
 */
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tabs_controller.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: PageView(
            controller: controller.pageController,
            children: controller.pages,
            onPageChanged: (i) {
              controller.setCurrentIndex(i);
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            fixedColor: Colors.red,
            currentIndex: controller.currentIndex.value,
            type: BottomNavigationBarType.fixed,
            onTap: (i) {
              controller.setCurrentIndex(i);
              controller.pageController.jumpToPage(i);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
              BottomNavigationBarItem(icon: Icon(Icons.category), label: "分类"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.room_service), label: "服务"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: "购物车"),
              BottomNavigationBarItem(icon: Icon(Icons.people), label: "用户")
            ],
          ),
        ));
  }
}
