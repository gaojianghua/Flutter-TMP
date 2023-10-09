/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 11:25:27
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-09 15:49:12
 * @Description: file content
 */
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: Container(
        child: Column(
          children: [],
        ),
      )
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: (){},
        child: Text('加'),
      ),
    );
  }
}
