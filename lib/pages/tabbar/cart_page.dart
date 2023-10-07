/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 11:25:27
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-07 13:44:47
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../models/card_model.dart';
import '../../components/card_item.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List? cardList;

  //获取商品数据
  getSquarePageContent() async {
    String jsonString = await rootBundle.loadString('data/data.json');
    Map<String, dynamic> jsonMap = await json.decode(jsonString);
    setState(() {
      //商品列表
      cardList = (jsonMap['cards'] as List).cast();
    });
  }

  @override
  void initState() {
    getSquarePageContent();
    super.initState();
  }

  //下拉刷新方法
  Future<void> _onRefresh() async {
    print("_onRefresh");
  }

  //上拉加载方法
  Future<void> _onLoadMore() async {
    print("_onLoadMore");
  }

  @override
  Widget build(BuildContext context) {
    if (cardList == null) {
      return Text('没有数据');
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('购物车'),
        ),
        body: Container(
            padding: EdgeInsets.all(3.0),
            child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemCount: cardList!.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = new Cards.fromJson(cardList![index]);
                  return CardItem(item);
                })),
      );
    }
  }
}
