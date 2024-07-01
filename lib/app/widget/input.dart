/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-21 15:47:56
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-22 10:16:38
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'package:flutter_tmp/app/services/screenAdapter.dart';

class Input extends StatelessWidget {
  final bool isPassWord;
  final String hintText;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  const Input(
      {super.key,
      this.controller,
      required this.hintText,
      this.onChanged,
      this.isPassWord = false,
      this.keyboardType = TextInputType.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: ScreenAdapter.height(180),
      margin: EdgeInsets.only(top: ScreenAdapter.height(40)),
      padding: EdgeInsets.only(left: ScreenAdapter.width(40)),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        // autofocus: true,
        controller: controller,
        obscureText: isPassWord,
        style: TextStyle(fontSize: ScreenAdapter.fontSize(48)),
        keyboardType: keyboardType, //默认弹出数字键盘
        decoration:
            InputDecoration(hintText: hintText, border: InputBorder.none //去掉下划线
                ),
        onChanged: onChanged,
      ),
    );
  }
}
