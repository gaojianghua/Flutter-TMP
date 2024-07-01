/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-13 18:32:02
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-16 09:40:26
 * @Description: file content
 */
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_tmp/app/services/httpsClient.dart';
import 'package:flutter_tmp/app/services/screenAdapter.dart';

import '../controllers/product_list_controller.dart';

class ProductListView extends GetView<ProductListController> {
  const ProductListView({Key? key}) : super(key: key);

  Widget _productList() {
    return ListView.builder(
      controller: controller.scrollController,
      padding: EdgeInsets.fromLTRB(
          ScreenAdapter.width(26),
          ScreenAdapter.height(140),
          ScreenAdapter.width(26),
          ScreenAdapter.height(10)),
      itemCount: controller.productList.length,
      itemBuilder: ((context, index) {
        return InkWell(
            onTap: () {
              Get.toNamed('/product-detail',
                  arguments: {"id": controller.productList[index].sId});
            },
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(bottom: ScreenAdapter.height(26)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(ScreenAdapter.width(60)),
                        width: ScreenAdapter.width(400),
                        height: ScreenAdapter.height(460),
                        child: Image.network(
                            "${HttpsClient.replaceUri(controller.productList[index].sPic)}",
                            fit: BoxFit.fitHeight)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: ScreenAdapter.height(20)),
                            child: Text(
                              "${controller.productList[index].title}",
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(42),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: ScreenAdapter.height(20)),
                            child: Text(
                              "${controller.productList[index].subTitle}",
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(34)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                bottom: ScreenAdapter.height(20)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "",
                                        style: TextStyle(
                                            fontSize:
                                                ScreenAdapter.fontSize(34),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "",
                                        style: TextStyle(
                                            fontSize:
                                                ScreenAdapter.fontSize(34)),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "",
                                        style: TextStyle(
                                            fontSize:
                                                ScreenAdapter.fontSize(34),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "",
                                        style: TextStyle(
                                            fontSize:
                                                ScreenAdapter.fontSize(34)),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "",
                                        style: TextStyle(
                                            fontSize:
                                                ScreenAdapter.fontSize(34),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "",
                                        style: TextStyle(
                                            fontSize:
                                                ScreenAdapter.fontSize(34)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text(
                            "￥${controller.productList[index].price}起",
                            style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(38),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              (index == controller.productList.length - 1)
                  ? _progressIndicator()
                  : const Text("")
            ]));
      }),
    );
  }

  Widget _subHeader() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: Obx(() => Container(
            height: ScreenAdapter.height(120),
            width: ScreenAdapter.width(1080),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                        width: ScreenAdapter.height(2),
                        color: const Color.fromRGBO(233, 233, 233, 0.9)))),
            child: Row(
                children: controller.subHeaderList.map((value) {
              return Expanded(
                  flex: 1,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.subHeaderChange(value["id"]);
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                0,
                                ScreenAdapter.height(16),
                                0,
                                ScreenAdapter.height(16)),
                            child: Text(
                              "${value["title"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color:
                                      controller.selectHeaderId == value["id"]
                                          ? Colors.red
                                          : Colors.black54,
                                  fontSize: ScreenAdapter.fontSize(32)),
                            ),
                          ),
                        ),
                        _showIcon(value["id"])
                      ]));
            }).toList()),
          )),
    );
  }

  // 自定义箭头组件
  Widget _showIcon(id) {
    if (id == 2 ||
        id == 3 ||
        controller.subHeaderListSort.value == 1 ||
        controller.subHeaderListSort.value == -1) {
      if (controller.subHeaderList[id - 1]["sort"] == 1) {
        return const Icon(Icons.arrow_drop_down, color: Colors.black54);
      } else {
        return const Icon(Icons.arrow_drop_up, color: Colors.black54);
      }
    } else {
      return const Text("");
    }
  }

  Widget _progressIndicator() {
    if (controller.hasData.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const Center(
        child: Text("没有数据，我是有底线的"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: controller.scaffoldGlobalKey,
        endDrawer: const Drawer(
          child: DrawerHeader(
            child: Text("右侧筛选"),
          ),
        ),
        // backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
        appBar: AppBar(
          title: InkWell(
              onTap: () {
                Get.offAndToNamed("/search");
              },
              child: Container(
                width: ScreenAdapter.width(900),
                height: ScreenAdapter.height(96),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(246, 246, 246, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(ScreenAdapter.width(34), 0,
                          ScreenAdapter.width(10), 0),
                      child: const Icon(
                        Icons.search,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                        controller.keywords != null
                            ? "${controller.keywords}"
                            : "",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: ScreenAdapter.fontSize(32)))
                  ],
                ),
              )),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: const [Text("")],
        ),
        body: Obx(() => controller.productList.isNotEmpty
            ? Stack(
                children: [_productList(), _subHeader()],
              )
            : _progressIndicator()));
  }
}
