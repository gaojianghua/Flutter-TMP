/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 11:31:00
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-10 18:01:46
 * @Description: file content
 */
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_refresh/easy_refresh.dart';
import '../../models/category_model.dart';
import '../../store/category_store.dart';
import '../../models/category_goods_list.dart';
import '../../store/category_goods_list_store.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('分类'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CategoryStore()),
          BlocProvider(create: (_) => CategoryGoodsListStore()),
        ],
        child: Row(
          children: [
            CategoryLevel(),
            Column(
              children: [CategoryRightTabs(), CategoryGoodsList()],
            )
          ],
        ),
      ),
    );
  }
}

// 分类左侧类别菜单
class CategoryLevel extends StatefulWidget {
  State<CategoryLevel> createState() => _CategoryLevelState();
}

class _CategoryLevelState extends State<CategoryLevel> {
  List list = [];
  var current = 0;
  @override
  void initState() {
    super.initState();
    getCategory();
    getGoodsList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(
        right: BorderSide(width: 1, color: Colors.black12),
      )),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return leftInkWell(index);
        },
      ),
    );
  }

  Widget leftInkWell(int i) {
    late bool isClick = false;
    isClick = (i == current) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          current = i;
        });
        var childList = list[i].bxMallSubDto;
        var categoryId = list[i].mallCategoryId;
        context.read<CategoryStore>().setCategory(childList, categoryId);
        getGoodsList(categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(84),
        padding: EdgeInsets.only(left: 20, top: 20),
        decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 236, 236, 1) : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          list[i].mallCategoryName,
          style: TextStyle(
              color: isClick ? Colors.blue : Colors.black,
              fontSize: ScreenUtil().setSp(44.sp),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void getCategory() async {
    String jsonString = await rootBundle.loadString('data/category.json');
    Map<String, dynamic> jsonMap = await json.decode(jsonString);
    CategoryModel category = CategoryModel.fromJson(jsonMap);
    setState(() {
      list = category.data;
    });
    context.read<CategoryStore>().setCategory(
        category.data[0].bxMallSubDto, category.data[0].mallCategoryId);
  }

  void getGoodsList([String? categoryId]) async {
    // var data = {
    //   "categoryId": categoryId == null ? '4' : categoryId,
    //   "categorySubId": "",
    //   "page": 1,
    //   "pageSize": 10,
    // };
    String jsonString = await rootBundle
        .loadString(categoryId == '1' ? 'data/goods.json' : 'data/goods1.json');
    Map<String, dynamic> jsonMap = await json.decode(jsonString);
    CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(jsonMap);
    if (goodsList.data == null) {
      context.read<CategoryGoodsListStore>().setCategoryGoodsList([]);
    } else {
      context
          .read<CategoryGoodsListStore>()
          .setCategoryGoodsList(goodsList.data);
    }
  }
}

// 分类右侧头部Tabs
class CategoryRightTabs extends StatefulWidget {
  const CategoryRightTabs({super.key});

  @override
  State<CategoryRightTabs> createState() => _CategoryRightTabsState();
}

class _CategoryRightTabsState extends State<CategoryRightTabs> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryStore, MyState>(
        builder: (context, state) => Container(
              height: ScreenUtil().setHeight(84),
              width: ScreenUtil().setWidth(570),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12))),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  return tabsInkWell(index, state.list[index], state);
                },
              ),
            ));
  }

  Widget tabsInkWell(int i, BxMallSubDto item, MyState state) {
    bool isClick = false;
    isClick = (i == state.childIndex) ? true : false;
    return InkWell(
      onTap: () {
        context.read<CategoryStore>().changeChildIndex(i, item.mallSubId);
        getGoodsList(item.mallSubId, state);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(44.sp),
              color: isClick ? Colors.red : Colors.black),
        ),
      ),
    );
  }

  void getGoodsList(String categorySubId, MyState state) async {
    // var data = {
    //   "categoryId": state.categoryId,
    //   "categorySubId": state.categorySubId,
    //   "page": 1,
    //   "pageSize": 10,
    // };
    String jsonString = await rootBundle.loadString(
        state.categorySubId == '2c9f6c94621970a801626a35cb4d0175'
            ? 'data/goods.json'
            : 'data/goods1.json');
    Map<String, dynamic> jsonMap = await json.decode(jsonString);
    CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(jsonMap);
    if (goodsList.data == null) {
      context.read<CategoryGoodsListStore>().setCategoryGoodsList([]);
    } else {
      context
          .read<CategoryGoodsListStore>()
          .setCategoryGoodsList(goodsList.data);
    }
  }
}

class CategoryGoodsList extends StatefulWidget {
  const CategoryGoodsList({super.key});

  @override
  State<CategoryGoodsList> createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  var scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryGoodsListStore, List<GoodsData>>(
        builder: (context, list) {
      return BlocBuilder<CategoryStore, MyState>(builder: (context, state) {
        try {
          if (state.page == 1) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scrollController.jumpTo(0.0);
            });
          }
        } catch (e) {}
        if (list.length > 0) {
          return Expanded(
              child: Container(
                  width: ScreenUtil().setWidth(570),
                  child: EasyRefresh(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return listItem(list, index);
                      },
                    ),
                    header: const ClassicHeader(),
                    footer: ClassicFooter(
                      noMoreText: state.noMoreText,
                    ),
                    onLoad: () {
                      getMoreGoodsList(state);
                      print(list);
                    },
                    onRefresh: () async {},
                  )));
        } else {
          return Center(child: Text('暂无商品'));
        }
      });
    });
  }

  Widget goodsIamge(List<GoodsData> list, int i) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(list[i].image),
    );
  }

  Widget goodsName(List<GoodsData> list, int i) {
    return Container(
      padding: EdgeInsets.all(5),
      width: ScreenUtil().setWidth(370),
      child: Text(
        list[i].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(44.sp)),
      ),
    );
  }

  Widget goodsPrice(List<GoodsData> list, int i) {
    return Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(top: 30),
        width: ScreenUtil().setWidth(370),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: [
            Text(
              '价格:￥${list[i].presentPrice}',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(50.sp),
                  textBaseline: TextBaseline.alphabetic,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                '原价:￥${list[i].oriPrice}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(38.sp),
                  color: Colors.black45,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            )
          ],
        ));
  }

  Widget listItem(List<GoodsData> list, int i) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Row(
          children: [
            goodsIamge(list, i),
            Column(children: [
              goodsName(list, i),
              goodsPrice(list, i),
            ])
          ],
        ),
      ),
    );
  }

  void getMoreGoodsList(MyState state) async {
    // context.read<CategoryStore>().addPage()
    // var data = {
    //   "categoryId": state.categoryId,
    //   "categorySubId": state.categorySubId,
    //   "page": state.page,
    //   "pageSize": 10,
    // };
    String jsonString = await rootBundle.loadString(
        state.categorySubId == '2c9f6c94621970a801626a35cb4d0175'
            ? 'data/goods.json'
            : 'data/goods1.json');
    Map<String, dynamic> jsonMap = await json.decode(jsonString);
    CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(jsonMap);
    if (goodsList.data == null) {
      context.read<CategoryStore>().changeNoMoreText('没有更多了');
    } else {
      context.read<CategoryGoodsListStore>().setMoreGoodsList(goodsList.data);
    }
  }
}
