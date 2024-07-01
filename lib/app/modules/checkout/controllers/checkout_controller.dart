/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-04-04 19:18:30
 * @LastEditors: 高江华
 * @LastEditTime: 2024-04-07 20:33:34
 * @Description: file content
 */
import 'package:get/get.dart';
import 'package:flutter_tmp/app/services/storage.dart';

class CheckoutController extends GetxController {
  RxList checkoutList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getCheckoutData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getCheckoutData() async {
    List tempList = await Storage.getData("checkoutList");
    checkoutList.value = tempList;
    update();
  }
}
