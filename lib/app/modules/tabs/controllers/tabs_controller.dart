/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-08 11:25:45
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-22 13:51:14
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tmp/app/modules/cart/views/cart_view.dart';
import 'package:flutter_tmp/app/modules/category/views/category_view.dart';
import 'package:flutter_tmp/app/modules/give/views/give_view.dart';
import 'package:flutter_tmp/app/modules/home/views/home_view.dart';
import 'package:flutter_tmp/app/modules/user/views/user_view.dart';

class TabsController extends GetxController {
  RxInt currentIndex = 0.obs;
  PageController pageController=Get.arguments!=null?PageController(initialPage:Get.arguments["initialPage"]): PageController(initialPage:0);
  final List<Widget> pages = [
    const HomeView(),
    const CategoryView(),
    const GiveView(),
    CartView(),
    UserView()
  ];

  @override
  void onInit() {
    if(Get.arguments!=null){
      currentIndex.value=Get.arguments["initialPage"];
      update();
    }
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setCurrentIndex(i) {
    currentIndex.value = i;
    super.update();
  }
}
