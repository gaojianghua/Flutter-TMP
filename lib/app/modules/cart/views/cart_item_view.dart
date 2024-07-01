/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-19 11:06:17
 * @LastEditors: 高江华
 * @LastEditTime: 2024-04-01 10:20:14
 * @Description: file content
 */
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_tmp/app/modules/cart/controllers/cart_controller.dart';
import 'package:flutter_tmp/app/modules/cart/views/cart_item_number_view.dart';
import 'package:flutter_tmp/app/services/httpsClient.dart';
import 'package:flutter_tmp/app/services/screenAdapter.dart';

class CartItemView extends GetView {
  @override
  final CartController controller = Get.find();
  final Map cartItem;
  CartItemView(this.cartItem, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenAdapter.width(20)),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: const Color.fromARGB(178, 240, 236, 236),
                width: ScreenAdapter.height(2))),
        color: Colors.white,
      ),
      child: Row(
        children: [
          SizedBox(
              width: ScreenAdapter.width(100),
              child: Checkbox(
                  activeColor: Colors.red,
                  shape: const CircleBorder(),
                  materialTapTargetSize:
                      MaterialTapTargetSize.shrinkWrap, // 去除 Checkbox 的默认内边距
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                  value: cartItem["checked"],
                  onChanged: (value) {
                    controller.checkCartItem(cartItem);
                  })),
          Container(
            padding: EdgeInsets.all(ScreenAdapter.width(24)),
            margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
            width: ScreenAdapter.width(260),
            child: Image.network(HttpsClient.replaceUri(cartItem["pic"]),
                fit: BoxFit.fitHeight),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${cartItem["title"]}",
                  style: TextStyle(
                      fontSize: ScreenAdapter.fontSize(46),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: ScreenAdapter.height(10)),
                Container(
                    padding: EdgeInsets.only(
                        top: ScreenAdapter.height(3),
                        right: ScreenAdapter.width(20),
                        bottom: ScreenAdapter.height(3),
                        left: ScreenAdapter.width(20)),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black54,
                            width: ScreenAdapter.fontSize(2)),
                        borderRadius:
                            BorderRadius.circular(ScreenAdapter.fontSize(10))),
                    child: Text(
                      "${cartItem["selectAttr"]}",
                      style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(30),
                      ),
                    )),
                SizedBox(height: ScreenAdapter.height(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "￥${cartItem["price"]}",
                      style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(48),
                          color: Colors.red),
                    ),
                    CartItemNumberView(cartItem)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
