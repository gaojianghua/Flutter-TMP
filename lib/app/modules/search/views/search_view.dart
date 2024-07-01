/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-14 16:14:42
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-15 20:20:39
 * @Description: file content
 */
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_tmp/app/services/screenAdapter.dart';
import 'package:flutter_tmp/app/services/searchServices.dart';

import '../controllers/searchs_controller.dart';
import 'dart:io' show Platform;

class SearchView extends GetView<SearchsController> {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      appBar: AppBar(
          title: Container(
            width: ScreenAdapter.width(800),
            height: ScreenAdapter.height(96),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(246, 246, 246, 1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              cursorHeight: ScreenAdapter.height(46),
              autofocus: true,
              decoration: InputDecoration(
                  contentPadding: Platform.isIOS ? const EdgeInsets.all(0) : EdgeInsets.only(top: ScreenAdapter.height(15)),
                  prefixIcon: const Icon(Icons.search, color: Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  )),
              // 输入框内容变化
              onChanged: (value) {
                controller.keywords = value;
              },
              // 搜索提交
              onSubmitted: (value) {
                SearchServices.setHistoryData(controller.keywords);
                Get.offAndToNamed("/product-list",
                    arguments: {"keywords": value});
              },
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            TextButton(
                // 搜索提交
                onPressed: () {
                  SearchServices.setHistoryData(controller.keywords);
                  Get.offAndToNamed("/product-list",
                      arguments: {"keywords": controller.keywords});
                },
                child: const Text("搜索",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black)))
          ]),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        children: [
          Obx(() => controller.historyList.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "搜索历史",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenAdapter.fontSize(42)),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.bottomSheet(Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                color: Colors.white,
                              ),
                              width: ScreenAdapter.width(1080),
                              height: ScreenAdapter.height(560),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      color: Color.fromARGB(255, 245, 86, 86),
                                    ),
                                    width: double.infinity,
                                    height: ScreenAdapter.height(120),
                                    child: Center(
                                      child: Text(
                                        "温馨提示",
                                        style: TextStyle(
                                            fontSize:
                                                ScreenAdapter.fontSize(40),
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenAdapter.height(50),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "您确定要清空历史记录吗？",
                                        style: TextStyle(
                                            fontSize:
                                                ScreenAdapter.fontSize(48)),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: ScreenAdapter.height(50),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: ScreenAdapter.width(420),
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color.fromARGB(
                                                            66, 169, 166, 166)),
                                                foregroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color.fromARGB(
                                                            221, 33, 32, 32))),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text("取消")),
                                      ),
                                      SizedBox(
                                        width: ScreenAdapter.width(420),
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color.fromARGB(
                                                            255, 55, 142, 242)),
                                                foregroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white)),
                                            onPressed: () {
                                              controller.clearHistoryData();
                                            },
                                            child: const Text("确定")),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ));
                          },
                          icon: const Icon(Icons.delete_forever_outlined))
                    ],
                  ))
              : const Text("")),
          Obx(() => Wrap(
                children: controller.historyList.map((value) {
                  return GestureDetector(
                      onLongPress: () {
                        Get.defaultDialog(
                          title: "提示信息",
                          middleText: "您确定要删除吗？",
                          confirm: ElevatedButton(onPressed: () {
                            controller.removeHistoryData(value);
                            Get.back();
                          }, child: const Text("确定")),
                          cancel: ElevatedButton(onPressed: () {
                            Get.back();
                          }, child: const Text("取消"))
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            ScreenAdapter.width(32),
                            ScreenAdapter.width(16),
                            ScreenAdapter.width(32),
                            ScreenAdapter.width(16)),
                        margin: EdgeInsets.all(ScreenAdapter.height(16)),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(value),
                      ));
                }).toList(),
              )),
          SizedBox(
            height: ScreenAdapter.height(50),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "猜你想搜",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenAdapter.fontSize(42)),
                  ),
                  const Icon(Icons.refresh)
                ],
              )),
          Wrap(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text("手机"),
              )
            ],
          ),
          SizedBox(
            height: ScreenAdapter.height(50),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(138),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/hot_search.png"))),
                ),
                Container(
                  padding: EdgeInsets.all(ScreenAdapter.width(20)),
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: 8,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: ScreenAdapter.width(40),
                          mainAxisSpacing: ScreenAdapter.height(20),
                          childAspectRatio: 3 / 1),
                      itemBuilder: ((context, index) {
                        return Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: ScreenAdapter.width(120),
                              padding: EdgeInsets.all(ScreenAdapter.width(10)),
                              child: Image.network(
                                "https://wolffy-website.oss-cn-hangzhou.aliyuncs.com/service4.jpg",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding:
                                    EdgeInsets.all(ScreenAdapter.width(10)),
                                child: const Text(""),
                              ),
                            )
                          ],
                        );
                      })),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
