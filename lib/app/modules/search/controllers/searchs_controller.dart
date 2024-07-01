/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-14 16:14:42
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-15 16:04:52
 * @Description: file content
 */

import 'package:get/get.dart';
import 'package:flutter_tmp/app/services/searchServices.dart';
import 'package:flutter_tmp/app/services/storage.dart';

class SearchsController extends GetxController {

  String keywords = "";
  RxList historyList = [].obs;
  
  @override
  void onInit() {
    super.onInit();
    getHistoryData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getHistoryData() async {
    var tempList = await SearchServices.getHistoryData();
    if (tempList.isNotEmpty) {
      historyList.addAll(tempList);
      update();
    }
  }
  
  void clearHistoryData() async {
    await SearchServices.clearHistoryData();
    historyList.clear();
    update();
  }
  
  void removeHistoryData(value) async {
    var tempList = await SearchServices.getHistoryData();
    if (tempList.isNotEmpty) {
      tempList.remove(value);
      await Storage.setData("searchList", tempList);
      historyList.remove(value);
      update();
    }
  }
}
