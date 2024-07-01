/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-08 11:26:25
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-13 17:52:13
 * @Description: file content
 */
import 'package:get/get.dart';
import 'package:flutter_tmp/app/models/category_model.dart';
import 'package:flutter_tmp/app/services/httpsClient.dart';

class CategoryController extends GetxController {
  RxInt selectIndex = 0.obs;
  RxList<CategoryItemModel> leftCategoryList = <CategoryItemModel>[].obs;
  RxList<CategoryItemModel> rightCategoryList = <CategoryItemModel>[].obs;
  HttpsClient https = HttpsClient();

  @override
  void onInit() {
    super.onInit();
    getLeftCategoryList();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // 切换一级分类
  void changeIndex(index) {
    selectIndex.value = index;
    getRightCategoryList(leftCategoryList[index].sId!);
    update();
  }

  // 切换一级分类
  void getLeftCategoryList() async {
    var response = await https.get("/api/pcate");
    if (response != null) {
      var category = CategoryModel.fromJson(response.data);
      leftCategoryList.value = category.result!;
      getRightCategoryList(leftCategoryList[0].sId!);
      update();
    }
  }

  // 切换二级分类
  void getRightCategoryList(String pid) async {
    var response = await https.get("/api/pcate?pid=$pid");
    if (response != null) {
      var category = CategoryModel.fromJson(response.data);
      rightCategoryList.value = category.result!;
      update();
    }
  }
}
