/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 11:03:34
 * @LastEditors: 高江华
 * @LastEditTime: 2023-09-21 14:18:17
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'my_page.dart';
import 'cart_page.dart';

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
    const CartPage(),
    const MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.pink,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index){
          setState(() {
            currentIndex = index;
            currentPage = pages[currentIndex];
          });
        },
      ),
      body: currentPage,
    );
  }
}