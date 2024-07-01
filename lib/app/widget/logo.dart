/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-21 14:51:21
 * @LastEditors: 高江华
 * @LastEditTime: 2024-07-01 10:27:19
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'package:flutter_tmp/app/services/screenAdapter.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
      child: SizedBox(
        width: ScreenAdapter.width(180),
        height: ScreenAdapter.width(180),
        child: Image.asset(
          "assets/images/logo.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
