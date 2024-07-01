/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-13 17:33:26
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-15 10:27:00
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tmp/app/models/plist_model.dart';
import 'package:flutter_tmp/app/services/httpsClient.dart';

class ProductListController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldGlobalKey = GlobalKey();
  ScrollController scrollController = ScrollController();
  RxList<PlistItemModel> productList = <PlistItemModel>[].obs;
  int page = 1;
  int pageSize = 10;
  bool flag = true;
  RxBool hasData = true.obs;
  String sort = "";
  HttpsClient https = HttpsClient();
  // 二级导航数据
  List subHeaderList = [
    {"id": 1, "title": "综合", "fileds": "all", "sort": -1},
    {"id": 2, "title": "销量", "fileds": "salecount", "sort": -1},
    {"id": 3, "title": "价格", "fileds": "price", "sort": -1},
    {"id": 4, "title": "筛选", "fileds": "all", "sort": -1}
  ];
  // 二级导航选择判断
  RxInt selectHeaderId = 1.obs;
  // 处理箭头变化
  RxInt subHeaderListSort = 0.obs;
  // 获取路由传值
  String? keywords = Get.arguments['keywords'];
  String? cid = Get.arguments['cid'];
  String apiUri = "";

  @override
  void onInit() {
    super.onInit();
    getProductList();
    ininScrollController();
  }

  void subHeaderChange(int id) {
    if (id == 4) {
      scaffoldGlobalKey.currentState!.openEndDrawer();
      selectHeaderId.value = id;
    } else {
      selectHeaderId.value = id;
      sort =
          "${subHeaderList[id - 1]["fileds"]}_${subHeaderList[id - 1]["sort"]}";
      subHeaderList[id - 1]["sort"] = subHeaderList[id - 1]["sort"] * -1;
      subHeaderListSort.value = subHeaderList[id - 1]["sort"];
      page = 1;
      productList.value = [];
      hasData.value = true;
      scrollController.jumpTo(0);
      getProductList();
    }
  }

  void ininScrollController() {
    scrollController.addListener(() {
      // scrollController.position.pixels 滚动条滚动高度
      // scrollController.position.maxScrollExtent 页面的高度
      if (scrollController.position.pixels >
          (scrollController.position.maxScrollExtent - 20)) {
        getProductList();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getProductList() async {
    if (flag == true && hasData.value == true) {
      flag = false;
      if (cid != null) {
        apiUri = "/api/plist?cid=$cid&page=$page&pageSize=$pageSize&sort=$sort";
      }else if (keywords != null) {
        apiUri = "/api/plist?search=$keywords&page=$page&pageSize=$pageSize&sort=$sort";
      }
      var response = await https.get(apiUri);
      if (response != null) {
        var pList = PlistModel.fromJson(response.data);
        productList.addAll(pList.result!);
        page++;
        update();
        flag = true;
        if (pList.result!.length < pageSize) {
          hasData.value = false;
        }
      }
    }
  }
}
