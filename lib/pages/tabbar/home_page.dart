/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 11:25:16
 * @LastEditors: 高江华
 * @LastEditTime: 2024-01-29 17:47:32
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'package:flutter_shop/generated/l10n.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/main.dart';
import 'package:flutter_shop/store/system_store.dart';
import '../../models/home_model.dart';
import '../../pages/common/goods_detail_page.dart';
import '../../store/home_store.dart';
import 'package:get/get.dart';
import '../../main_models/launcher/index.dart';
import 'package:easy_refresh/easy_refresh.dart';

import '../home/news_page.dart';

class HomePage extends StatefulWidget {
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => false;

  int page = 1;
  List<Cards> flowGoodsList = [];
  late EasyRefreshController homeController;

  @override
  void initState() {
    getHomePageContent();
    homeController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    homeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final systemStore = BlocProvider.of<SystemStore>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('首页'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.language),
              onPressed: () {
                // 切换到英文
                systemStore.setLanguage(Locale('en'));
                runApp(MyApp());
              },
            ),
            IconButton(
              icon: Icon(Icons.language),
              onPressed: () {
                // 切换到中文
                systemStore.setLanguage(Locale('zh'));
              },
            ),
            // 添加更多的自定义按钮
          ],
        ),
        body: BlocBuilder<HomeStore, HomeData>(builder: (context, state) {
          return EasyRefresh(
            // controller: homeController,
            child: state.slides.length > 0
                ? CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: EasyRefresh(
                          child: SwiperDiy(swiperList: state.slides),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: MenuDiy(menuList: state.menus),
                      ),
                      SliverToBoxAdapter(
                        child: LeaderPhone(
                          leaderImage: state.shopInfo.leaderImage,
                          leaderPhone: state.shopInfo.leaderPhone,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: RecommendedGoods(goodsList: state.goodsList),
                      ),
                      SliverToBoxAdapter(
                        child: FloorContent(
                          floorGoodsList: state.floorGoodsListOne,
                          floorGoodsTitle: state.floorGoodsTitleOne,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: FloorContent(
                          floorGoodsList: state.floorGoodsListTwo,
                          floorGoodsTitle: state.floorGoodsTitleTwo,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: hotGoods(),
                      ),
                    ],
                  )
                : Text('加载中'),
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 2));
              if (!mounted) {
                return;
              }
              getHomePageContent();
              homeController.finishRefresh();
              homeController.resetFooter();
            },
            onLoad: () async {
              await Future.delayed(const Duration(seconds: 2));
              if (!mounted) {
                return;
              }
              getHomePageContent('S');
              homeController.finishLoad(flowGoodsList.length >= 20
                  ? IndicatorResult.noMore
                  : IndicatorResult.success);
            },
          );
        }));
  }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10, bottom: 10),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text(S.current.hotTitle),
  );

  Widget wrapList() {
    if (flowGoodsList.length != 0) {
      List<Widget> listWidget = flowGoodsList
          .map((e) {
            return InkWell(
              onTap: () {
                Get.toNamed('/goods_detail', arguments: {
                  'goodsId': e.goodsId,
                });
              },
              child: Container(
                width: ScreenUtil().setWidth(356),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black12,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: EdgeInsets.only(bottom: 8),
                child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                        child: Image.network(
                          e.img,
                          fit: BoxFit.cover,
                          width: ScreenUtil().setWidth(356),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 5, bottom: 10, left: 5, right: 5),
                      child: Text(
                        e.des,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(45.sp),
                            color: Colors.black87),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 5, bottom: 5, left: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '￥${e.mallPrice}',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(50.sp),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            Text(
                              '￥${e.price}',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(45.sp),
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            );
          })
          .cast<Widget>()
          .toList();
      return Wrap(
        spacing: 8,
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

  // 获取数据
  getHomePageContent([String? e]) async {
    String jsonString = await rootBundle.loadString('data/home.json');
    late Map<String, dynamic> jsonMap;
    try {
      jsonMap = await json.decode(jsonString);
    } catch (e) {
      print('JSON decode error: $e');
    }

    if (jsonMap.containsKey('data')) {
      try {
        Map<String, dynamic> jsonData = jsonMap['data'];
        HomeData homeData = HomeData.fromJson(jsonData);
        // 使用 homeData 进行后续操作
        context.read<HomeStore>().setHomeData(homeData);
        if (e == 'S') {
          setState(() {
            flowGoodsList.addAll(homeData.cards);
            page++;
          });
        } else {
          setState(() {
            flowGoodsList.addAll(homeData.cards);
            page = 1;
          });
        }
      } catch (e) {
        print('Error in processing homeData: $e');
      }
    } else {
      print('Invalid JSON data or missing "data" key');
    }
  }
}

// 首页轮播图
class SwiperDiy extends StatelessWidget {
  final List<Slides> swiperList;
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
                    goodsId: image.goodsId,
                  )),
              child: Image.network(
                image.url,
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
  final List<Menus> menuList;
  const MenuDiy({super.key, required this.menuList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(260),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(5.0),
        children: menuList.map((Menus item) {
          return _buildMenuItem(context, item);
        }).toList(),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, item) {
    return InkWell(
      onTap: () {
        Get.to(() => NewsPage());
      },
      child: Column(
        children: [
          Image.network(
            item.image,
            width: ScreenUtil().setWidth(95),
          ),
          Text(item.name, style: TextStyle(fontSize: ScreenUtil().setSp(36.sp)))
        ],
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
  final List<GoodsList> goodsList;
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
            goodsId: goodsList[i].goodsId,
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
            Image.network(goodsList[i].image),
            Container(
              height: ScreenUtil().setHeight(6),
            ),
            Text(
              '￥${goodsList[i].mallPrice}',
              style: TextStyle(
                color: Colors.red,
                fontSize: ScreenUtil().setSp(56.sp),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '￥${goodsList[i].price}',
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
  final List<FloorGoodsListOne> floorGoodsList;
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

  Widget goodsItem(FloorGoodsListOne goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () => Get.to(() => GoodsDetailPage(
              goodsId: goods.goodsId,
            )),
        child: Image.network(goods.image),
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
