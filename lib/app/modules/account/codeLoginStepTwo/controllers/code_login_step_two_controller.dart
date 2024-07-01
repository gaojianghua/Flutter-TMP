/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-21 17:05:55
 * @LastEditors: 高江华
 * @LastEditTime: 2024-04-07 22:27:24
 * @Description: file content
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_tmp/app/models/message.dart';
import 'package:flutter_tmp/app/modules/user/controllers/user_controller.dart';
import 'package:flutter_tmp/app/services/httpsClient.dart';
import 'package:flutter_tmp/app/services/storage.dart';

class CodeLoginStepTwoController extends GetxController {
  final TextEditingController editingController = TextEditingController();
  UserController userController = Get.find<UserController>();
  HttpsClient httpsClient = HttpsClient();
  String tel = Get.arguments["tel"];
  RxInt seconds = 10.obs;

  @override
  void onInit() {
    super.onInit();
    countDown();
  }

  @override
  void onClose() {
    userController.getUserInfo();
    super.onClose();
  }

  //倒计时的方法
  countDown() {
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      seconds.value--;
      if (seconds.value == 0) {
        timer.cancel();
      }
      update();
    });
  }

  //发送验证码
  Future<MessageModel> sendCode() async {
    var response =
        await httpsClient.post("api/sendLoginCode", data: {"tel": tel});
    if (response != null) {
      if (response.data["success"]) {
        //方便测试 正式上线需要删掉Clipboard代码
        Clipboard.setData(ClipboardData(text: response.data["code"]));
        seconds.value = 10;
        countDown();
        return MessageModel(message: "发送验证码成功", success: true);
      }
      return MessageModel(message: response.data["message"], success: false);
    } else {
      return MessageModel(message: "网络异常", success: false);
    }
  }

  //执行登录
  Future<MessageModel> doLogin() async {
    var response = await httpsClient.post("api/validateLoginCode",
        data: {"tel": tel, "code": editingController.text});

    if (response != null) {
      if (response.data["success"]) {
        //执行登录 保存用户信息
        Storage.setData("userinfo", response.data["userinfo"]);
        return MessageModel(message: "登录成功", success: true);
      }
      return MessageModel(message: response.data["message"], success: false);
    } else {
      return MessageModel(message: "网络异常", success: false);
    }
  }
}
