/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-08 11:27:05
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-22 13:58:42
 * @Description: file content
 */
import 'package:get/get.dart';
import 'package:flutter_tmp/app/models/user_model.dart';
import 'package:flutter_tmp/app/services/userServices.dart';

class UserController extends GetxController {
  RxBool isLogin = false.obs;
  // RxList userList = [].obs;
  var userInfo=UserModel().obs;
  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getUserInfo() async {
    var tempLoginState = await UserServices.getUserLoginState();
    isLogin.value = tempLoginState;
    var tempList = await UserServices.getUserInfo();
    if (tempList.isNotEmpty) {
      userInfo.value = UserModel.fromJson(tempList[0]);
    }
  }

  loginOut() {
    UserServices.loginOut();
    isLogin.value = false;
    userInfo.value = UserModel();
    update();
  }
}
