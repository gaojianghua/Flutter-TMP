/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-21 14:15:34
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-23 09:50:15
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_tmp/app/models/message.dart';
import 'package:flutter_tmp/app/services/httpsClient.dart';

class CodeLoginStepOneController extends GetxController {
  TextEditingController telController = TextEditingController();
  HttpsClient httpsClient = HttpsClient();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //发送验证码
  Future<MessageModel> sendCode() async {
    var response = await httpsClient
        .post("api/sendLoginCode", data: {"tel": telController.text});
    if (response != null) {
      print(response);
      if (response.data["success"]) {
        //方便测试 正式上线需要删掉Clipboard代码
        Clipboard.setData(ClipboardData(text: response.data["code"]));

        return MessageModel(message: "发送验证码成功", success: true);
      }
      return MessageModel(message: response.data["message"], success: false);
    } else {
      return MessageModel(message: "网络异常", success: false);
    }
  }
}
