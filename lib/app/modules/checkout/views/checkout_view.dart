/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-26 10:16:42
 * @LastEditors: 高江华
 * @LastEditTime: 2024-04-11 15:25:53
 * @Description: file content
 */
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_tmp/app/services/httpsClient.dart';
import 'package:flutter_tmp/app/services/screenAdapter.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({Key? key}) : super(key: key);

  Widget checkoutItem(element) {
    return Container(
      padding: EdgeInsets.all(ScreenAdapter.height(20)),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: ScreenAdapter.width(200),
            height: ScreenAdapter.height(200),
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            child: Image.network(HttpsClient.replaceUri(element["pic"]),
                fit: BoxFit.fitHeight),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${element["title"]}",
                    style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(42),
                        fontWeight: FontWeight.bold)),
                SizedBox(height: ScreenAdapter.height(10)),
                Text("${element["selectAttr"]}"),
                SizedBox(height: ScreenAdapter.height(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "￥${element["price"]}",
                      style: TextStyle(color: Colors.red),
                    ),
                    Text(
                      "x${element["count"]}",
                      style: TextStyle(color: Colors.black87),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget body() {
    return ListView(
      padding: EdgeInsets.all(ScreenAdapter.width(40)),
      children: [
        Container(
          padding: EdgeInsets.only(
              top: ScreenAdapter.height(20), bottom: ScreenAdapter.height(20)),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenAdapter.width(10))),
          child: ListTile(
            onTap: () {
              Get.toNamed("/address-list");
            },
            leading: const Icon(Icons.add_location),
            title: const Text("新建收货地址"),
            trailing: const Icon(Icons.navigate_next),
          ),
        ),
        SizedBox(
          height: ScreenAdapter.height(40),
        ),
        Container(
          padding: EdgeInsets.only(
              top: ScreenAdapter.height(20), bottom: ScreenAdapter.height(20)),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenAdapter.width(10))),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("张三 15257184434"),
                SizedBox(height: ScreenAdapter.height(10)),
                Text("藏龙东街藏龙星天地")
              ],
            ),
            trailing: Icon(Icons.navigate_next),
          ),
        ),
        SizedBox(
          height: ScreenAdapter.height(40),
        ),
        Container(
          padding: EdgeInsets.only(
              top: ScreenAdapter.height(20), bottom: ScreenAdapter.height(20)),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenAdapter.width(10))),
          child: Obx(() => controller.checkoutList.isNotEmpty ? Column(
            children: controller.checkoutList.map((element) {
              return checkoutItem(element);
            }).toList()
          ) : Text("")),
        ),
        SizedBox(
          height: ScreenAdapter.height(40),
        ),
        Container(
          padding: EdgeInsets.only(
              top: ScreenAdapter.height(20), bottom: ScreenAdapter.height(20)),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenAdapter.width(10))),
          child: Column(
            children: [
              const ListTile(
                title: Text("运费"),
                trailing: Wrap(
                  children: [Text("包邮")],
                ),
              ),
              ListTile(
                title: Text("优惠券"),
                trailing: Wrap(
                  children: [Text("无可用"), Icon(Icons.navigate_next)],
                ),
              ),
              ListTile(
                title: Text("礼卡券"),
                trailing: Wrap(
                  children: [Text("无可用"), Icon(Icons.navigate_next)],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: ScreenAdapter.height(40),
        ),
        Container(
          padding: EdgeInsets.only(
              top: ScreenAdapter.height(20), bottom: ScreenAdapter.height(20)),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenAdapter.width(10))),
          child: Column(
            children: [
              const ListTile(
                title: Text("发票"),
                trailing: Wrap(
                  children: [Icon(Icons.navigate_next)],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget bottom() {
    return Positioned(
      left: 0,
      bottom: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
            left: ScreenAdapter.width(20), right: ScreenAdapter.width(20)),
        width: double.infinity,
        height: ScreenAdapter.height(190),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: const Color.fromARGB(178, 240, 236, 236),
                    width: ScreenAdapter.height(2))),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text("共1件，合计："),
                Text(
                  "￥99.9",
                  style: TextStyle(
                      fontSize: ScreenAdapter.fontSize(58), color: Colors.red),
                ),
                SizedBox(width: ScreenAdapter.width(20)),
              ],
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(251, 72, 5, 0.9)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)))),
                onPressed: () {},
                child: const Text("去付款"))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('确认订单'),
          centerTitle: true,
        ),
        body: Stack(
          children: [body(), bottom()],
        ));
  }
}
