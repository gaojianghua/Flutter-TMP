/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 11:03:34
 * @LastEditors: 高江华
 * @LastEditTime: 2024-01-27 17:40:52
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/store/home_store.dart';
import 'package:flutter_shop/store/system_store.dart';
import '../../store/category_goods_list_store.dart';
import '../../store/category_store.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'my_page.dart';
import 'cart_page.dart';
import 'message_page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '首页',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: '分类',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.message),
      label: '消息',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: '购物车',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: '我的',
    ),
  ];

  int currentIndex = 0;
  // ignore: prefer_typing_uninitialized_variables
  var currentPage;

  @override
  void initState() {
    currentPage = pages[currentIndex];
    super.initState();
  }

  final List<Widget> pages = [
    BlocProvider<HomeStore>(
        create: (context) => HomeStore(), child: HomePage()),
    MultiBlocProvider(providers: [
      BlocProvider(create: (_) => CategoryStore()),
      BlocProvider(create: (_) => CategoryGoodsListStore()),
    ], child: CategoryPage()),
    MessagePage(),
    CartPage(),
    MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemStore, SystemState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xffeeeeee),
          type: BottomNavigationBarType.fixed, //如果底部有4个或者4个以上的菜单的时候就需要配置这个参数
          currentIndex: state.tabbarIndex,
          items: bottomTabs,
          onTap: (index) {
            context.read<SystemStore>().setTabbarIndex(index);
          },
        ),
        body: IndexedStack(
          index: state.tabbarIndex,
          children: pages,
        ),
      );
    });
  }
}
