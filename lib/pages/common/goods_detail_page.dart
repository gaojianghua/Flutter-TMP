/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-11 13:47:37
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-12 16:25:33
 * @Description: file content
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/store/cart_store.dart';
import 'goods_detail_logic.dart';
import 'package:flutter_html/flutter_html.dart';

class GoodsDetailPage extends StatefulWidget {
  final String? goodsId;
  const GoodsDetailPage({super.key, this.goodsId});

  @override
  State<GoodsDetailPage> createState() =>
      _GoodsDetailPageState(goodsId: goodsId);
}

class _GoodsDetailPageState extends State<GoodsDetailPage> {
  late final String? goodsId;
  int changeId = 1;
  _GoodsDetailPageState({required this.goodsId});

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
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => CartStore()),
          ],
          child: FutureBuilder(
            future: GoodsDetailLogic.getGoodsDetail(goodsId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = json.decode(snapshot.data.toString());
                String image = data['data']['goodInfo']['image1'];
                String name = data['data']['goodInfo']['goodsName'];
                String sn = data['data']['goodInfo']['goodsSerialNumber'];
                double price = data['data']['goodInfo']['presentPrice'];
                double oldPrice = data['data']['goodInfo']['oriPrice'];
                String info = data['data']['goodInfo']['goodsDetail'];
                return Stack(children: [
                  Container(
                      padding:
                          EdgeInsets.only(bottom: ScreenUtil().setHeight(80)),
                      child: ListView(children: [
                        goodsIamge(image),
                        goodsName(name),
                        goodsSn(sn),
                        goodsPrice(price, oldPrice),
                        goodsBread(),
                        Row(
                          children: [
                            goodsTabsLeft(),
                            goodsTabsRight(),
                          ],
                        ),
                        changeId == 1 ? goodsHtml(info) : goodsComments()
                      ])),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      child: BlocBuilder<CartStore, List>(
                          builder: (context, state) {
                        return Container(
                            color: Colors.white,
                            height: ScreenUtil().setHeight(80),
                            width: ScreenUtil().setWidth(750),
                            child: Row(children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: ScreenUtil().setWidth(150),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.shopping_cart,
                                    size: 35,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<CartStore>().save(
                                        data['data']['goodInfo']['goodsId'],
                                        data['data']['goodInfo']['goodsName'],
                                        1,
                                        data['data']['goodInfo']
                                            ['presentPrice'],
                                        data['data']['goodInfo']['image1'],
                                      );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: ScreenUtil().setHeight(80),
                                  width: ScreenUtil().setWidth(300),
                                  color: Colors.green,
                                  child: Text(
                                    '加入购物车',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(50.sp),
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<CartStore>().remove();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: ScreenUtil().setHeight(80),
                                  width: ScreenUtil().setWidth(300),
                                  color: Colors.red,
                                  child: Text(
                                    '立即购买',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(50.sp),
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ]));
                      }))
                ]);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }

  Widget goodsComments() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Text('123'),
    );
  }

  Widget goodsHtml(String info) {
    return Container(
      child: Html(
        data: info,
        style: {
          'body': Style(
              backgroundColor: Colors.white,
              padding: HtmlPaddings.all(0),
              margin: Margins.all(0)),
          'img': Style(padding: HtmlPaddings.all(0), margin: Margins.all(0)),
        },
      ),
    );
  }

  Widget goodsTabsLeft() {
    return InkWell(
      onTap: () {
        setState(() {
          changeId = 1;
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
                width: 1, color: changeId == 1 ? Colors.red : Colors.black12),
          ),
        ),
        child: Text(
          '详情',
          style: TextStyle(
            color: changeId == 1 ? Colors.red : Colors.black,
            fontSize: ScreenUtil().setSp(46.sp),
          ),
        ),
      ),
    );
  }

  Widget goodsTabsRight() {
    return InkWell(
      onTap: () {
        setState(() {
          changeId = 2;
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
                width: 1, color: changeId == 2 ? Colors.red : Colors.black12),
          ),
        ),
        child: Text(
          '评论',
          style: TextStyle(
            color: changeId == 2 ? Colors.red : Colors.black,
            fontSize: ScreenUtil().setSp(46.sp),
          ),
        ),
      ),
    );
  }

  Widget goodsBread() {
    return Container(
        padding: EdgeInsets.only(left: 15),
        color: Colors.white,
        margin: EdgeInsets.only(top: 10, bottom: 10),
        width: ScreenUtil().setWidth(740),
        child: Text(
          '说明: > 极速送达 > 正品保证',
          style: TextStyle(
            color: Colors.red,
            fontSize: ScreenUtil().setSp(50.sp),
          ),
        ));
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
            fontSize: ScreenUtil().setSp(46.sp),
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
