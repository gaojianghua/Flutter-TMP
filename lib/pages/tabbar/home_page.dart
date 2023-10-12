/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 11:25:16
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-12 10:58:34
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/pages/common/goods_detail_page.dart';
import 'package:get/get.dart';
import '../../main_models/launcher/index.dart';
import 'package:easy_refresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  List<Map> flowGoodsList = [];
  late EasyRefreshController _controller;
  // 页面缓存
  @override
  bool get wantKeepAlive => true;
  // 获取数据
  getHomePageContent() async {
    return await rootBundle.loadString('data/home.json');
  }

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text('首页')),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map<String, dynamic>> swiper =
                (data['data']['slides'] as List).cast();
            List<Map> menus = (data['data']['menus'] as List).cast();
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            List<Map> goodsList = (data['data']['goodsList'] as List).cast();
            String floorGoodsTitleOne = data['data']['floorGoodsTitleOne'];
            List<Map> floorGoodsListOne =
                (data['data']['floorGoodsListOne'] as List).cast();
            String floorGoodsTitleTwo = data['data']['floorGoodsTitleTwo'];
            List<Map> floorGoodsListTwo =
                (data['data']['floorGoodsListTwo'] as List).cast();
            return EasyRefresh(
              controller: _controller,
              child: ListView(
                children: [
                  SwiperDiy(swiperList: swiper),
                  MenuDiy(menuList: menus),
                  LeaderPhone(
                      leaderImage: leaderImage, leaderPhone: leaderPhone),
                  RecommendedGoods(goodsList: goodsList),
                  FloorContent(
                      floorGoodsList: floorGoodsListOne,
                      floorGoodsTitle: floorGoodsTitleOne),
                  FloorContent(
                      floorGoodsList: floorGoodsListTwo,
                      floorGoodsTitle: floorGoodsTitleTwo),
                  hotGoods()
                ],
              ),
              header: const ClassicHeader(),
              footer: const ClassicFooter(),
              onLoad: () async {
                await Future.delayed(const Duration(seconds: 2));
                if (!mounted) {
                  return;
                }
                String jsonString =
                    await rootBundle.loadString('data/home.json');
                Map<String, dynamic> jsonMap = await json.decode(jsonString);
                List<Map> newGoodsList =
                    (jsonMap['data']['cards'] as List).cast();
                if (flowGoodsList.length != 0) {
                  setState(() {
                    flowGoodsList.addAll(newGoodsList);
                    page++;
                  });
                } else {
                  setState(() {
                    flowGoodsList = newGoodsList;
                    page = 1;
                  });
                }
                _controller.finishLoad(flowGoodsList.length >= 20
                    ? IndicatorResult.noMore
                    : IndicatorResult.success);
              },
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 2));
                if (!mounted) {
                  return;
                }
                String jsonString =
                    await rootBundle.loadString('data/home.json');
                Map<String, dynamic> jsonMap = await json.decode(jsonString);
                List<Map> newGoodsList =
                    (jsonMap['data']['cards'] as List).cast();
                setState(() {
                  flowGoodsList = newGoodsList;
                  page = 1;
                });
                _controller.finishRefresh();
                _controller.resetHeader();
                _controller.resetFooter();
              },
            );
          } else {
            return Center(
              child: Text('加载中...'),
            );
          }
        },
      ),
    );
  }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10, bottom: 10),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text('火爆专区'),
  );

  Widget wrapList() {
    if (flowGoodsList.length != 0) {
      List<Widget> listWidget = flowGoodsList
          .map((e) {
            return InkWell(
              onTap: () => Get.to(() => GoodsDetailPage(
                    goodsId: e['goodsId'],
                  )),
              child: Container(
                width: ScreenUtil().setWidth(368),
                color: Colors.white,
                padding: EdgeInsets.only(left: 1, right: 1),
                margin: EdgeInsets.only(bottom: 3),
                child: Column(
                  children: [
                    Image.network(
                      e['img'],
                      fit: BoxFit.cover,
                      width: ScreenUtil().setWidth(368),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        e['des'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(45.sp),
                            color: Colors.green),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '￥${e['mallPrice']}',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(50.sp),
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        Text(
                          '￥${e['price']}',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(45.sp),
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          })
          .cast<Widget>()
          .toList();
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('暂无数据');
    }
  }

  Widget hotGoods() {
    return Container(
      child: Column(
        children: [hotTitle, wrapList()],
      ),
    );
  }
}

// 首页轮播图
class SwiperDiy extends StatelessWidget {
  final List<Map<String, dynamic>> swiperList;
  SwiperDiy({required this.swiperList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(280),
      child: Swiper(
        itemBuilder: (context, index) {
          final image = swiperList[index];
          return InkWell(
              onTap: () => Get.to(() => GoodsDetailPage(
                    goodsId: image['goodsId'],
                  )),
              child: Image.network(
                image['url'],
                fit: BoxFit.cover,
              ));
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
      onTap: () {
        print('123');
      },
      child: Column(
        children: [
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['name'],
              style: TextStyle(fontSize: ScreenUtil().setSp(36.sp)))
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
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(5.0),
        children: menuList.map((item) {
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
      child: Image.network(
        url,
        fit: BoxFit.cover,
      ),
    );
  }
}

// 首页店长电话
class LeaderPhone extends StatelessWidget {
  final String leaderPhone;
  final String leaderImage;
  const LeaderPhone(
      {super.key, required this.leaderImage, required this.leaderPhone});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => UrlLauncher.launchPhoneCall(leaderPhone),
        child: Image.network(leaderImage),
      ),
    );
  }
}

// 首页热门商品
class RecommendedGoods extends StatelessWidget {
  final List<Map> goodsList;
  const RecommendedGoods({Key? key, required this.goodsList}) : super(key: key);
  // 头部标题
  Widget titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: Text(
        '热门商品',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  // 热门商品
  Widget goodsWidget(int i) {
    return InkWell(
      onTap: () => Get.to(() => GoodsDetailPage(
            goodsId: goodsList[i]['goodsId'],
          )),
      child: Container(
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(left: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: Column(
          children: [
            Image.network(goodsList[i]['image']),
            Container(
              height: ScreenUtil().setHeight(6),
            ),
            Text(
              '￥${goodsList[i]['mallPrice']}',
              style: TextStyle(
                color: Colors.red,
                fontSize: ScreenUtil().setSp(56.sp),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '￥${goodsList[i]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
                fontSize: ScreenUtil().setSp(46.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 商品列表
  Widget goodsListWidget() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: goodsList.length,
        itemBuilder: (context, index) {
          return goodsWidget(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(332),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          titleWidget(),
          Expanded(
            child: goodsListWidget(),
          )
        ],
      ),
    );
  }
}

// 首页类组商品
class FloorContent extends StatelessWidget {
  final List<Map> floorGoodsList;
  final String floorGoodsTitle;
  const FloorContent(
      {super.key, required this.floorGoodsList, required this.floorGoodsTitle});

  Widget firstRow() {
    return Row(
      children: [
        goodsItem(floorGoodsList[0]),
        Column(children: [
          goodsItem(floorGoodsList[1]),
          goodsItem(floorGoodsList[2]),
        ])
      ],
    );
  }

  Widget secondRow() {
    return Row(
      children: [
        goodsItem(floorGoodsList[3]),
        goodsItem(floorGoodsList[4]),
      ],
    );
  }

  Widget goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () => Get.to(() => GoodsDetailPage(
              goodsId: goods['goodsId'],
            )),
        child: Image.network(goods['image']),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Image.network(floorGoodsTitle),
          ),
          firstRow(),
          secondRow()
        ],
      ),
    );
  }
}
