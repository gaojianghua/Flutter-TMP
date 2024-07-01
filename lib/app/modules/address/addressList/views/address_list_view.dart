/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-04-11 14:56:07
 * @LastEditors: 高江华
 * @LastEditTime: 2024-04-11 16:07:43
 * @Description: file content
 */
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_tmp/app/services/screenAdapter.dart';

import '../controllers/address_list_controller.dart';

class AddressListView extends GetView<AddressListController> {
  const AddressListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('收货地址'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(ScreenAdapter.width(20)),
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.check, color: Colors.red,),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "武汉 江夏区",
                          style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(38),
                            color: Colors.black54,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: ScreenAdapter.height(20)),
                        Text(
                          "藏龙-星天地 9栋 2单元 402",
                          style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(46),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: ScreenAdapter.height(20)),
                        Text(
                          "高江华 15257184434"
                        )
                      ],
                    ),
                    trailing: Icon(Icons.edit, color: Colors.blue,),
                  ),
                  Divider(),
                  ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "武汉 江夏区",
                          style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(38),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: ScreenAdapter.height(20)),
                        Text(
                          "藏龙-星天地 9栋 2单元 402",
                          style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(46),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: ScreenAdapter.height(20)),
                        Text(
                          "高江华 15257184434"
                        )
                      ],
                    ),
                    trailing: Icon(Icons.edit, color: Colors.blue,),
                  ),
                  Divider(),
                  ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "武汉 江夏区",
                          style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(38),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: ScreenAdapter.height(20)),
                        Text(
                          "藏龙-星天地 9栋 2单元 402",
                          style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(46),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: ScreenAdapter.height(20)),
                        Text(
                          "高江华 15257184434"
                        )
                      ],
                    ),
                    trailing: Icon(Icons.edit, color: Colors.blue,),
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    padding: EdgeInsets.all(ScreenAdapter.width(20)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                          // 设置顶部边框
                          color: Colors.black45,
                          width: ScreenAdapter.height(2), // 边框宽度
                        ),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed("/address-add");
                      },
                      child: Container(
                        height: ScreenAdapter.height(140),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(251, 72, 5, 0.9),
                            borderRadius: BorderRadius.circular(50)),
                        child: const Text(
                          "新增收货地址",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )))
          ],
        ));
  }
}
