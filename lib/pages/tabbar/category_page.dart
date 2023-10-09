/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 11:31:00
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-09 17:48:51
 * @Description: file content
 */
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/category_model.dart';
import '../../store/category_store.dart';

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
      body: BlocProvider(
        create: (_) => CategoryStore(),
        child: Row(
          children: [
            CategoryLevel(),
            Column(
              children: [CategoryRightTabs()],
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
        context.read<CategoryStore>().setCategory(childList);
      },
      child: Container(
        height: ScreenUtil().setHeight(84),
        padding: EdgeInsets.only(left: 20, top: 20),
        decoration: BoxDecoration(
            color: isClick ? Colors.black12 : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          list[i].mallCategoryName,
          style: TextStyle(
            color: isClick ? Colors.blue : Colors.black,
              fontSize: ScreenUtil().setSp(44.sp), fontWeight: FontWeight.bold),
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
    context.read<CategoryStore>().setCategory(category.data[0].bxMallSubDto);
  }
}

// 分类右侧头部Tabs
class CategoryRightTabs extends StatefulWidget {
  const CategoryRightTabs({super.key});

  @override
  State<CategoryRightTabs> createState() => _CategoryRightTabsState();
}

class _CategoryRightTabsState extends State<CategoryRightTabs> {
  // List list = ['名酒','老酒', '新酒', '礼盒', '定制'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryStore, List<BxMallSubDto>>(
        builder: (context, list) => Container(
              height: ScreenUtil().setHeight(84),
              width: ScreenUtil().setWidth(570),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12))),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return tabsInkWell(list[index]);
                },
              ),
            ));
  }

  Widget tabsInkWell(BxMallSubDto item) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(44.sp)),
        ),
      ),
    );
  }
}
