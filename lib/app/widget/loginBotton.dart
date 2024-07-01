/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-21 16:35:16
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-22 09:59:17
 * @Description: file content
 */
import 'package:flutter/material.dart';
import '../services/screenAdapter.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const LoginButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ScreenAdapter.height(40)),
      height: ScreenAdapter.height(140),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Color.fromRGBO(240, 115, 49, 1)),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(ScreenAdapter.height(70))))),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: ScreenAdapter.fontSize(46)),
        ),
      ),
    );
  }
}
