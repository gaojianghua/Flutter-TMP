/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 11:25:16
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-07 14:48:19
 * @Description: file content
 */
// import 'package:dio/dio.dart';
// import 'package:flutter_shop/config/request/api/system.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../models/card_model.dart';
import '../../components/card_item.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

const images = <String>[
  'images/banner.jpeg',
  'images/banner.jpeg',
  'images/banner.jpeg',
];

class _HomePageState extends State<HomePage> {
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

  List<Widget> menu() {
    List<Widget> widgets = [];
    for (var i = 0; i < 10; i++) {
      widgets.add(GestureDetector(
          onTap: () {
            print('Column was tapped!');
          },
          child: Column(
            children: [
              Image.network(
                'https://gaojianghua.oss-cn-hangzhou.aliyuncs.com/wolffyPink.png',
                width: 50,
                height: 50,
              ),
              Container(
                margin: EdgeInsets.only(top: 6), // 设置四个方向的相同间距
                child: Text('Hello'),
              ),
            ],
          )));
    }
    return widgets;
  }

  goodsList() {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            child: Swiper(
              itemBuilder: (context, index) {
                final image = images[index];
                return Image.asset(
                  image,
                  fit: BoxFit.cover,
                );
              },
              indicatorLayout: PageIndicatorLayout.COLOR,
              autoplay: true,
              itemCount: images.length,
              pagination: const SwiperPagination(),
            ),
          ),
          Container(
            height: 200,
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(), // 禁止滚动
              child: GridView.count(
                crossAxisCount: 5, // 一行的 Widget 数量
                shrinkWrap: true, // 使 GridView 高度适应内容
                physics: ClampingScrollPhysics(),
                children: menu(),
              ),
            ),
          ),
          Container(
            height: 10,
            width: double.infinity,
            color: Color.fromRGBO(240, 240, 240, 1),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.all(3.0),
                child: cardList == null
                    ? Text('没有数据')
                    : MasonryGridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        itemCount: cardList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          var item = new Cards.fromJson(cardList![index]);
                          return CardItem(item);
                        })),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getSquarePageContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text('首页')),
      body: Column(
        children: [
          goodsList(),
        ],
      ),
    );
  }
}
