/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-11 13:47:37
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-11 17:03:39
 * @Description: file content
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'goods_detail_logic.dart';

class GoodsDetailPage extends StatelessWidget {
  final String? goodsId;
  const GoodsDetailPage({super.key, this.goodsId});

  getGoodsDetail(String goodsId) async {
    return await rootBundle.loadString('data/goods_detail.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('商品详情'),
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: GoodsDetailLogic.getGoodsDetail(goodsId!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            String image = data['data']['goodInfo']['image1'];
            String name = data['data']['goodInfo']['goodsName'];
            String sn = data['data']['goodInfo']['goodsSerialNumber'];
            double price = data['data']['goodInfo']['presentPrice'];
            double oldPrice = data['data']['goodInfo']['oriPrice'];
            return Container(
                child: Column(children: [
              goodsIamge(image),
              goodsName(name),
              goodsSn(sn),
              goodsPrice(price, oldPrice),
            ]));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget goodsIamge(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

  Widget goodsName(name) {
    return Container(
        padding: EdgeInsets.only(left: 15),
        width: ScreenUtil().setWidth(740),
        child: Text(
          name,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(56.sp),
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  Widget goodsSn(sn) {
    return Container(
        width: ScreenUtil().setWidth(740),
        padding: EdgeInsets.only(left: 15),
        margin: EdgeInsets.only(top: 8),
        child: Text(
          '编号：$sn',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(40.sp),
            color: Color(0xff999999),
          ),
        ));
  }

  Widget goodsPrice(price, oldPrice) {
    return Container(
        padding: EdgeInsets.only(left: 15),
        width: ScreenUtil().setWidth(740),
        margin: EdgeInsets.only(top: 8),
        child: Row(
          children: [
            Text(
              '¥$price',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(66.sp),
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '原价:¥$oldPrice',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(46.sp),
                  decoration: TextDecoration.lineThrough,
                  color: Colors.black26,
                ),
              ),
            )
          ],
        ));
  }
}
