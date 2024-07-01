/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-21 14:16:44
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-22 11:40:45
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tmp/app/models/message.dart';
import 'package:flutter_tmp/app/services/httpsClient.dart';
import 'package:flutter_tmp/app/services/storage.dart';

class RegisterStepThreeController extends GetxController {
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  HttpsClient httpsClient = HttpsClient();
  String tel = Get.arguments["tel"];
  String code = Get.arguments["code"];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //执行注册
  Future<MessageModel> doRegister() async {
    var response = await httpsClient.post("api/register",
        data: {"tel": tel, "password": passController.text, "code": code});
    if (response != null) {
      print(response);
      if (response.data["success"]) {
        //执行登录 保存用户信息
        Storage.setData("userinfo", response.data["userinfo"]);
        return MessageModel(message: "注册成功", success: true);
      }

      return MessageModel(message: response.data["message"], success: false);
    } else {
      return MessageModel(message: "网络异常", success: false);
    }
  }
}
