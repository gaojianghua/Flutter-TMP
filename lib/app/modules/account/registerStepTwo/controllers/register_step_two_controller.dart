/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-21 14:16:35
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-22 10:59:09
 * @Description: file content
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_tmp/app/services/httpsClient.dart';

class RegisterStepTwoController extends GetxController {
  final TextEditingController editingController = TextEditingController();
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

  //重新发送验证码
  void sendCode() async {
    var response = await httpsClient.post("api/sendCode", data: {"tel": tel});
    if (response != null) {
      print(response);
      if (!response.data["success"]) {
        Get.snackbar("提示信息!", "非常请求");
      } else {
        //测试：把验证码复制到剪切板上面，正式上线不需要这句话,这个为了方便测试
        Clipboard.setData(ClipboardData(text: response.data["code"]));

        seconds.value = 10;
        countDown();
        update();
      }
    } else {
      Get.snackbar("提示信息!", "网络异常请重试");
    }
  }

  //验证验证码
  Future<bool> validateCode() async {
    var response = await httpsClient.post("api/validateCode", data: {
      "tel": tel, //上一个页面穿过来的手机号
      "code": editingController.text
    });
    if (response != null) {
      if (response.data["success"]) {
        return true;
      }
      return false;
    } else {
      return false;
    }
  }
}
