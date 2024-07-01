/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-08 11:26:56
 * @LastEditors: 高江华
 * @LastEditTime: 2024-04-09 14:05:32
 * @Description: file content
 */
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_tmp/app/modules/cart/views/cart_item_view.dart';
import 'package:flutter_tmp/app/services/screenAdapter.dart';

import '../controllers/cart_controller.dart';

// 注意CartView如果在多个地方调用，需要手动获取CartController实例。
class CartView extends GetView {
  @override
  final CartController controller = Get.put(CartController());
  CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('购物车'),
        centerTitle: true,
        actions: [
          Obx(() => controller.isEdit.value
              ? TextButton(
                  onPressed: () {
                    controller.changeEditState();
                  },
                  child: const Text("完成"),
                )
              : TextButton(
                  onPressed: () {
                    controller.changeEditState();
                  },
                  child: const Text("编辑"),
                ))
        ],
      ),
      body: GetBuilder<CartController>(
          initState: (state) {
            controller.getCartList();
          },
          init: controller,
          builder: (controller) {
            return controller.cartList.isNotEmpty
                ? Stack(
                    children: [
                      ListView(
                        padding:
                            EdgeInsets.only(bottom: ScreenAdapter.height(200)),
                        children: controller.cartList.map((value) {
                          return CartItemView(value);
                        }).toList(),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.only(
                              left: ScreenAdapter.width(20),
                              right: ScreenAdapter.width(20)),
                          width: double.infinity,
                          height: ScreenAdapter.height(190),
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: const Color.fromARGB(
                                          178, 240, 236, 236),
                                      width: ScreenAdapter.height(2))),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Obx(() => Checkbox(
                                      checkColor: Colors.white, // 修改勾选标记的颜色
                                      activeColor:
                                          Colors.red, // 修改 Checkbox 的填充颜色
                                      shape: const CircleBorder(),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize
                                              .shrinkWrap, // 去除 Checkbox 的默认内边距
                                      visualDensity: const VisualDensity(
                                          horizontal: -4,
                                          vertical: -4), // 调整 Checkbox 的视觉密度
                                      value: controller.allChecked.value,
                                      onChanged: (value) {
                                        controller.checkAllCartItem(value);
                                      })),
                                  InkWell(
                                    onTap: () {
                                      controller.checkAllCartItem(
                                          !controller.allChecked.value);
                                    },
                                    child: const Text("全选"),
                                  )
                                ],
                              ),
                              Obx(() => controller.isEdit.value ?
                              Row(
                                children: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)))),
                                      onPressed: () {
                                        controller.deleteCartData();
                                      },
                                      child: const Text("删除"))
                                ],
                              ) : Row(
                                children: [
                                  const Text("合计："),
                                  Text(
                                    "￥99.9",
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.fontSize(58),
                                        color: Colors.red),
                                  ),
                                  SizedBox(width: ScreenAdapter.width(30)),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color.fromRGBO(
                                                      255, 165, 0, 0.9)),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)))),
                                      onPressed: () {
                                        controller.checkout();
                                      },
                                      child: const Text("结算"))
                                ],
                              ))
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : const Center(child: Text("购物车空空的"));
          }),
    );
  }
}
