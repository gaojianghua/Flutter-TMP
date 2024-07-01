/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-19 11:55:02
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-19 17:12:21
 * @Description: file content
 */
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_tmp/app/modules/productDetail/controllers/product_detail_controller.dart';
import 'package:flutter_tmp/app/services/screenAdapter.dart';

class CartItemNumberView extends GetView {
  @override
  final ProductDetailController controller = Get.find();
  CartItemNumberView({Key? key}) : super(key: key);

  Widget _left() {
    return InkWell(
        onTap: () {
          controller.decBuyNum();
        },
        child: Container(
          alignment: Alignment.center,
          width: ScreenAdapter.width(80),
          height: ScreenAdapter.height(70),
          child: Text(
            "-",
            style: TextStyle(fontSize: ScreenAdapter.fontSize(42)),
          ),
        ));
  }

  Widget _center() {
    return Obx(() => Container(
          alignment: Alignment.center,
          width: ScreenAdapter.width(80),
          height: ScreenAdapter.height(70),
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(
                      width: ScreenAdapter.width(2), color: Colors.black12),
                  right: BorderSide(
                      width: ScreenAdapter.width(2), color: Colors.black12))),
          child: Text("${controller.buyNum.value}"),
        ));
  }

  Widget _right() {
    return InkWell(
        onTap: () {
          controller.incBuyNum();
        },
        child: Container(
          alignment: Alignment.center,
          width: ScreenAdapter.width(80),
          height: ScreenAdapter.height(70),
          child: Text(
            "+",
            style: TextStyle(fontSize: ScreenAdapter.fontSize(42)),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(244),
      height: ScreenAdapter.height(70),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          border:
              Border.all(width: ScreenAdapter.width(2), color: Colors.black12)),
      child: Row(
        children: [_left(), _center(), _right()],
      ),
    );
  }
}
