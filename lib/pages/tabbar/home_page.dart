/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 11:25:16
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-07 17:59:52
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
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  //获取轮播图
  getHomePageContent() async {
    return await rootBundle.loadString('data/home.json');
  }
  // getHomePageContent() async {
  //   String jsonString = await rootBundle.loadString('data/data.json');
  //   Map<String, dynamic> jsonMap = await json.decode(jsonString);
  //   setState(() {
  //     //商品列表
  //     cardList = (jsonMap['cards'] as List).cast();
  //   });
  // }

  // goodsList() {
  //   return Expanded(
  //     child: Column(
  //       children: [
  //         Expanded(
  //           child: Container(
  //               padding: EdgeInsets.all(3.0),
  //               child: cardList == null
  //                   ? Text('没有数据')
  //                   : MasonryGridView.count(
  //                       crossAxisCount: 2,
  //                       mainAxisSpacing: 4,
  //                       crossAxisSpacing: 4,
  //                       itemCount: cardList!.length,
  //                       itemBuilder: (BuildContext context, int index) {
  //                         var item = new Cards.fromJson(cardList![index]);
  //                         return CardItem(item);
  //                       })),
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text('首页')),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot){
          if(snapshot.hasData) {
            print(snapshot.data);
            var data = json.decode(snapshot.data.toString());
            List<String> swiper = (data['data']['slides'] as List).cast();
            List<Map> menus = (data['data']['menus'] as List).cast();
            String url = data['data']['advert'];
            return Column(
              children: [
                SwiperDiy(swiperList: swiper),
                MenuDiy(menuList: menus),
                Advert(url: url)
              ],
            );
          }else{
            return Center(
              child: Text('加载中...'),
            );
          }
        },
      ),
    );
  }
}

// 首页轮播图
class SwiperDiy extends StatelessWidget {
  final List<String> swiperList;
  SwiperDiy({required this.swiperList});  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(280),
      child: Swiper(
        itemBuilder: (context, index) {
          final image = swiperList[index];
          return Image.network(
            image,
            fit: BoxFit.cover,
          );
        },
        indicatorLayout: PageIndicatorLayout.COLOR,
        autoplay: true,
        itemCount: swiperList.length,
        pagination: const SwiperPagination(),
      ),
    );
  }
}

// 首页菜单
class MenuDiy extends StatelessWidget {
  final List<Map> menuList;
  const MenuDiy({super.key, required this.menuList});

  Widget _buildMenuItem(BuildContext context, item) {
    return InkWell(
      onTap: (){print('123');},
      child: Column(
        children: [
          Image.network(item['image'], width: ScreenUtil().setWidth(95),),
          Text(item['name'], style: TextStyle(fontSize: ScreenUtil().setSp(36.sp)))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(260),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: menuList.map((item){
          return _buildMenuItem(context, item);
        }).toList(),
      ),
    );
  }
}

// 首页广告
class Advert extends StatelessWidget {
  final String url;
  const Advert({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(url),
    );
  }
}
