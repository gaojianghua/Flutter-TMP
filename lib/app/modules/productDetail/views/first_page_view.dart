/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-17 12:13:03
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-19 15:54:55
 * @Description: file content
 */
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_tmp/app/modules/productDetail/controllers/product_detail_controller.dart';
import 'package:flutter_tmp/app/services/httpsClient.dart';
import 'package:flutter_tmp/app/services/screenAdapter.dart';

class FirstPageView extends GetView {
  @override
  final ProductDetailController controller = Get.find();
  final Function showAttr;
  FirstPageView(this.showAttr, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.productDetail.value.sId != null ? SizedBox(
          key: controller.gk1,
          width: ScreenAdapter.width(1080),
          child: Column(
            children: [
              AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(
                      "${HttpsClient.replaceUri(controller.productDetail.value.pic)}",
                      fit: BoxFit.cover)),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                    top: ScreenAdapter.height(20),
                    left: ScreenAdapter.width(20),
                    right: ScreenAdapter.width(20)),
                child: Text(
                  "${controller.productDetail.value.title}",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenAdapter.fontSize(46)),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(ScreenAdapter.height(20)),
                child: Text(
                  "${controller.productDetail.value.subTitle}",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: ScreenAdapter.fontSize(34)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: ScreenAdapter.width(20),
                    right: ScreenAdapter.width(20)),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            "价格：",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                textBaseline: TextBaseline.alphabetic),
                          ),
                          Text(
                            "￥${controller.productDetail.value.price}",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenAdapter.fontSize(66),
                                textBaseline: TextBaseline.alphabetic),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            "原价：",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                textBaseline: TextBaseline.ideographic),
                          ),
                          Text(
                            "￥${controller.productDetail.value.oldPrice}",
                            style: TextStyle(
                                color: Colors.black26,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenAdapter.fontSize(46),
                                decoration: TextDecoration.lineThrough,
                                textBaseline: TextBaseline.ideographic),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // 筛选
              Container(
                height: ScreenAdapter.height(140),
                padding: EdgeInsets.only(
                    left: ScreenAdapter.width(20),
                    right: ScreenAdapter.width(20)),
                child: InkWell(
                    onTap: () {
                      showAttr(1);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "已选",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenAdapter.width(20)),
                              child: Text(controller.selectAttr.value),
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black38,
                          size: ScreenAdapter.fontSize(46),
                        )
                      ],
                    )),
              ),
              // 门店
              Container(
                height: ScreenAdapter.height(140),
                padding: EdgeInsets.only(
                    left: ScreenAdapter.width(20),
                    right: ScreenAdapter.width(20)),
                child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "门店",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenAdapter.width(20)),
                              child: const Text("小米之家万达专卖店"),
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black38,
                          size: ScreenAdapter.fontSize(46),
                        )
                      ],
                    )),
              ),
              // 服务
              Container(
                height: ScreenAdapter.height(140),
                padding: EdgeInsets.only(
                    left: ScreenAdapter.width(20),
                    right: ScreenAdapter.width(20)),
                child: InkWell(
                    onTap: () {
                      Get.bottomSheet(Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: ScreenAdapter.height(1000),
                        child: ListView(
                          children: [Text("")],
                        ),
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "服务",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenAdapter.width(20)),
                              child: Image.asset("assets/images/service.png"),
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black38,
                          size: ScreenAdapter.fontSize(46),
                        )
                      ],
                    )),
              )
            ],
          ),
        ): SizedBox(
          height: ScreenAdapter.height(2400),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
