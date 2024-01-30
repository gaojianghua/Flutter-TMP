/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 11:25:27
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-17 09:41:49
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'package:flutter_shop/generated/l10n.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.message),
        elevation: 0.0,
      ),
      body: Container(),
    );
  }
}