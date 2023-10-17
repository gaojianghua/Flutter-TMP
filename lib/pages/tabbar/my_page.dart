/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 11:25:45
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-17 09:42:15
 * @Description: file content
 */
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  //生命周期函数:当组件初始化的时候就会触发
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 9, vsync: this);
  }

  List<String> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
              //左侧的按钮图标
              icon: const Icon(Icons.menu),
              onPressed: () {
                print("左侧的按钮图标");
              },
            ),
            backgroundColor: Colors.red, //导航背景颜色
            title: const Text("Flutter App"),
            actions: [
              //右侧的按钮图标
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  print("搜索图标");
                },
              ),
              IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {
                  print("更多");
                },
              )
            ],
            bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.white,
                indicatorWeight: 2,
                indicatorPadding: const EdgeInsets.all(5),
                // indicatorSize:TabBarIndicatorSize.label,
                labelColor: Colors.yellow,
                unselectedLabelColor: Colors.white,
                labelStyle: const TextStyle(fontSize: 14),
                unselectedLabelStyle: const TextStyle(fontSize: 12),
                indicator: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                controller: _tabController, //注意：配置controller需要去掉TabBar上面的const
                tabs: const [
                  Tab(
                    child: Text("关注"),
                  ),
                  Tab(
                    child: Text("热门"),
                  ),
                  Tab(
                    child: Text("视频"),
                  ),
                  Tab(
                    child: Text("关注"),
                  ),
                  Tab(
                    child: Text("热门"),
                  ),
                  Tab(
                    child: Text("视频"),
                  ),
                  Tab(
                    child: Text("关注"),
                  ),
                  Tab(
                    child: Text("热门"),
                  ),
                  Tab(
                    child: Text("视频"),
                  ),
                ])),
        body: TabBarView(controller: _tabController, children: [
          const Text("我是关注"),
          const Text("我是关注"),
          const Text("我是关注"),
          const Text("我是关注"),
          const Text("我是关注"),
          const Text("我是关注"),
          const Text("我是关注"),
          ListView(
            children: const [
              ListTile(
                title: Text("我是热门列表"),
              ),
              ListTile(
                title: Text("我是热门列表"),
              ),
              ListTile(
                title: Text("我是热门列表"),
              ),
              ListTile(
                title: Text("我是热门列表"),
              ),
              ListTile(
                title: Text("我是热门列表"),
              ),
              ListTile(
                title: Text("我是热门列表"),
              ),
              ListTile(
                title: Text("我是热门列表"),
              ),
            ],
          ),
          ListView(
            children: const [
              ListTile(
                title: Text("我是视频列表"),
              )
            ],
          )
        ]));
  }
}
