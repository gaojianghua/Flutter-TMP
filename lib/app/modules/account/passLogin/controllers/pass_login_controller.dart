/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-21 14:16:16
 * @LastEditors: 高江华
 * @LastEditTime: 2024-04-01 16:44:59
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tmp/app/models/message.dart';
import 'package:flutter_tmp/app/modules/user/controllers/user_controller.dart';
import 'package:flutter_tmp/app/services/httpsClient.dart';
import 'package:flutter_tmp/app/services/storage.dart';

class PassLoginController extends GetxController {
  TextEditingController telController = TextEditingController();
  TextEditingController passController = TextEditingController();
  UserController userController = Get.find<UserController>();
  HttpsClient httpsClient = HttpsClient();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    userController.getUserInfo();
    super.onClose();
  }

  Future<MessageModel> doLogin() async {
    var response = await httpsClient.post("api/doLogin", data: {
      "username": telController.text,
      "password": passController.text,
    });
    if (response != null) {
      print(response);
      if (response.data["success"]) {
        //保存用户信息
        Storage.setData("userinfo", response.data["userinfo"]);
        return MessageModel(message: "登录成功", success: true);
      }
      return MessageModel(message: response.data["message"], success: false);
    } else {
      return MessageModel(message: "网络异常", success: false);
    }
  }
}
