import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import 'package:get/get.dart';
import 'package:flutter_tmp/app/services/httpsClient.dart';

import '../controllers/home_controller.dart';

import '../../../services/keepAliveWrapper.dart';

import "../../../services/screenAdapter.dart";

import "../../../services/ityingFonts.dart";

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  // tabbar
  Widget _appBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Obx(() => AppBar(
            leading: controller.flag.value
                ? const Text("")
                : const Icon(
                    ItyingFonts.xiaomi,
                    color: Colors.white
                  ),
            leadingWidth: controller.flag.value
                ? ScreenAdapter.width(40)
                : ScreenAdapter.width(140),
            title: InkWell(
                onTap: () {
                  Get.toNamed("/search");
                },
                child: AnimatedContainer(
                  width: controller.flag.value
                      ? ScreenAdapter.width(800)
                      : ScreenAdapter.width(620),
                  height: ScreenAdapter.height(96),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(246, 246, 246, 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  duration: const Duration(milliseconds: 600),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(ScreenAdapter.width(34), 0,
                            ScreenAdapter.width(10), 0),
                        child: const Icon(Icons.search,color: Colors.black54,),
                      ),
                      Text("手机",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: ScreenAdapter.fontSize(32)))
                    ],
                  ),
                )),
            centerTitle: true,
            backgroundColor:
                controller.flag.value ? Colors.white : Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.qr_code,
                    color:
                        controller.flag.value ? Colors.black87 : Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.message,
                      color: controller.flag.value
                          ? Colors.black87
                          : Colors.white))
            ],
          )),
    );
  }

  // 顶部轮播图
  Widget _focus() {
    return SizedBox(
      width: ScreenAdapter.width(1080),
      height: ScreenAdapter.height(682),
      child: Obx(() => Swiper(
            itemCount: controller.swiperList.length,
            physics: const NeverScrollableScrollPhysics(), // 禁止滑动
            itemBuilder: (c, i) {
              return Image.network(
                  HttpsClient.replaceUri(controller.swiperList[i].pic),
                  fit: BoxFit.fill);
            },
            pagination: const SwiperPagination(builder: SwiperPagination.rect),
            autoplay: true,
            loop: true,
          )),
    );
  }

  // banner
  Widget _banner() {
    return SizedBox(
      width: ScreenAdapter.width(1080),
      height: ScreenAdapter.height(92),
      child: Image.asset(
        "assets/images/xiaomiBanner.png",
        fit: BoxFit.fill,
      ),
    );
  }

  // 大图banner
  Widget _banner2() {
    return Padding(
        padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20),
            ScreenAdapter.height(20), ScreenAdapter.width(20), 0),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenAdapter.width(10)),
                image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/xiaomiBanner2.png"))),
            height: ScreenAdapter.height(420)));
  }

  // 分类菜单
  Widget _category() {
    return SizedBox(
        width: ScreenAdapter.width(1080),
        height: ScreenAdapter.height(470),
        child: Obx(
          () => Swiper(
            itemBuilder: (context, index) {
              return GridView.builder(
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: ScreenAdapter.width(20),
                      mainAxisSpacing: ScreenAdapter.height(20)),
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: ScreenAdapter.height(136),
                          height: ScreenAdapter.height(136),
                          child: Image.network(
                              HttpsClient.replaceUri(
                                  controller.categoryList[index * 10 + i].pic),
                              fit: BoxFit.fitHeight),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, ScreenAdapter.height(4), 0, 0),
                          child: Text(
                            "${controller.categoryList[index * 10 + i].title}",
                            style:
                                TextStyle(fontSize: ScreenAdapter.fontSize(34)),
                          ),
                        )
                      ],
                    );
                  });
            },
            itemCount: controller.categoryList.length ~/ 10,
            pagination: SwiperPagination(
                margin: const EdgeInsets.all(0.0),
                builder: SwiperCustomPagination(
                    builder: (BuildContext context, SwiperPluginConfig config) {
                  return ConstrainedBox(
                    constraints:
                        BoxConstraints.expand(height: ScreenAdapter.height(20)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: const RectSwiperPaginationBuilder(
                              color: Colors.black12,
                              activeColor: Colors.black54,
                            ).build(context, config),
                          ),
                        )
                      ],
                    ),
                  );
                })),
          ),
        ));
  }

  // 热销臻选左侧轮播
  _sellingLeftSwiper() {
    return Swiper(
      itemCount: controller.bestSellingSwiperList.length,
      itemBuilder: (c, i) {
        return Image.network(
            HttpsClient.replaceUri(controller.bestSellingSwiperList[i].pic),
            fit: BoxFit.fill);
      },
      pagination: SwiperPagination(
          margin: const EdgeInsets.all(0.0),
          builder: SwiperCustomPagination(
              builder: (BuildContext context, SwiperPluginConfig config) {
            return ConstrainedBox(
              constraints:
                  BoxConstraints.expand(height: ScreenAdapter.height(36)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: const RectSwiperPaginationBuilder(
                        color: Colors.black12,
                        activeColor: Colors.black54,
                      ).build(context, config),
                    ),
                  )
                ],
              ),
            );
          })),
      autoplay: true,
      loop: true,
    );
  }

  // 热销臻选
  Widget _bestSelling() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(ScreenAdapter.width(30),
              ScreenAdapter.height(20), ScreenAdapter.width(30), 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "热销臻选",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenAdapter.fontSize(46)),
              ),
              Text(
                "更多手机 >",
                style: TextStyle(fontSize: ScreenAdapter.fontSize(38)),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20), 0,
              ScreenAdapter.width(40), ScreenAdapter.height(20)),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: SizedBox(
                      height: ScreenAdapter.height(738),
                      child: Obx(() => _sellingLeftSwiper()))),
              SizedBox(
                width: ScreenAdapter.width(20),
              ),
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: ScreenAdapter.height(738),
                    child: Obx(() => Column(
                            children: controller.sellingPList
                                .asMap()
                                .entries
                                .map((entries) {
                          var item = entries.value;
                          return Expanded(
                            flex: 1,
                            child: Container(
                              color: const Color.fromRGBO(246, 246, 246, 1),
                              margin: EdgeInsets.fromLTRB(
                                  0,
                                  0,
                                  0,
                                  entries.key == 2
                                      ? 0
                                      : ScreenAdapter.height(20)),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                              height: ScreenAdapter.height(20)),
                                          Text("${item.title}",
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenAdapter.fontSize(
                                                          38),
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                              height: ScreenAdapter.height(20)),
                                          Text("${item.subTitle}",
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenAdapter.fontSize(
                                                          28))),
                                          SizedBox(
                                              height: ScreenAdapter.height(20)),
                                          Text("￥${item.price}元",
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenAdapter.fontSize(
                                                          32)))
                                        ],
                                      )),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                          ScreenAdapter.height(8)),
                                      child: Image.network(
                                          HttpsClient.replaceUri(item.pic),
                                          fit: BoxFit.cover),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList())),
                  )),
            ],
          ),
        )
      ],
    );
  }
  // 省心优惠列表
  _masonryGridView() {
    return MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: ScreenAdapter.width(26),
        crossAxisSpacing: ScreenAdapter.width(26),
        itemCount: controller.bestPList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.toNamed('/product-detail', arguments: {
                "id": controller.bestPList[index].sId
              });
            },
            child:  Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(ScreenAdapter.width(10)),
                  child: Image.network(
                    HttpsClient.replaceUri(controller.bestPList[index].sPic),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(ScreenAdapter.width(10)),
                    child: Text(
                      "${controller.bestPList[index].title}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(36),
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(ScreenAdapter.width(10)),
                    child: Text(
                      "${controller.bestPList[index].subTitle}",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: ScreenAdapter.fontSize(32)),
                    )),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(ScreenAdapter.width(10)),
                    child: Text(
                      "￥${controller.bestPList[index].price}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(42),
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ))
              ],
            ),
          ));
        });
  }
  // 省心优惠
  Widget _bestGoods() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(ScreenAdapter.width(30),
              ScreenAdapter.height(20), ScreenAdapter.width(30), 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "省心优惠",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenAdapter.fontSize(46)),
              ),
              Text(
                "更多优惠 >",
                style: TextStyle(fontSize: ScreenAdapter.fontSize(38)),
              )
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.all(ScreenAdapter.width(26)),
            color: const Color.fromRGBO(246, 246, 246, 1),
            child: Obx(() => _masonryGridView()))
      ],
    );
  }

  Widget _homePage() {
    return Positioned(
        top: -60,
        left: 0,
        right: 0,
        bottom: 0,
        child: ListView(
          controller: controller.scrollController,
          children: [
            _focus(),
            _banner(),
            _category(),
            _banner2(),
            _bestSelling(),
            _bestGoods()
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
        child: Scaffold(
      body: Stack(
        children: [_homePage(), _appBar()],
      ),
    ));
  }
}
