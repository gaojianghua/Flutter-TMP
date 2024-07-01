/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-21 14:16:44
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-22 11:53:56
 * @Description: file content
 */
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_tmp/app/models/message.dart';
import 'package:flutter_tmp/app/services/screenAdapter.dart';
import 'package:flutter_tmp/app/widget/input.dart';
import 'package:flutter_tmp/app/widget/loginBotton.dart';
import 'package:flutter_tmp/app/widget/logo.dart';

import '../controllers/register_step_three_controller.dart';

class RegisterStepThreeView extends GetView<RegisterStepThreeController> {
  const RegisterStepThreeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text("手机号快速注册"),
        actions: [TextButton(onPressed: () {}, child: const Text("帮助"))],
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.width(40)),
        children: [
          const LogoWidget(),
          //输入手机号
          Input(
              controller: controller.passController,
              isPassWord: true,
              hintText: "请输入密码",
              keyboardType: TextInputType.text,
              onChanged: (value) {
                print(value);
              }),

          Input(
              controller: controller.confirmPassController,
              isPassWord: true,
              keyboardType: TextInputType.text,
              hintText: "请输入确认密码",
              onChanged: (value) {
                print(value);
              }),

          SizedBox(height: ScreenAdapter.height(20)),
          LoginButton(
              text: "完成注册",
              onPressed: () async {
                if (controller.passController.text !=
                    controller.confirmPassController.text) {
                  Get.snackbar("提示信息！", "密码和确认密码不一致");
                } else if (controller.passController.text.length < 6) {
                  Get.snackbar("提示信息！", "密码长度不能小于6位");
                } else {
                  MessageModel result = await controller.doRegister();
                  if (result.success) {
                    //执行跳转  回到根
                    Get.offAllNamed("/tabs", arguments: {
                      "initialPage": 4 //注册完成后会加载tabs第五个页面
                    });
                  } else {
                    Get.snackbar("提示信息！", result.message);
                  }
                }
              }),
        ],
      ),
    );
  }
}
