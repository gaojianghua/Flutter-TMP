/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 11:03:34
 * @LastEditors: 高江华
 * @LastEditTime: 2023-09-25 17:24:24
 * @Description: file content
 */
import 'package:flutter/material.dart';
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
    const HomePage(),
    const CategoryPage(),
    const MessagePage(),
    const CartPage(),
    const MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffeeeeee),
        type: BottomNavigationBarType.fixed,  //如果底部有4个或者4个以上的菜单的时候就需要配置这个参数
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = pages[currentIndex];
          });
        },
      ),
      body: currentPage,
      floatingActionButton: Container(
        height: 60,
        width: 60,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(top: 0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: FloatingActionButton(
          // backgroundColor: currentPage == 2 ? Colors.red : Colors.blue,
          onPressed: () {
            setState(() {
              currentIndex = 2;
              currentPage = pages[currentIndex];
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
