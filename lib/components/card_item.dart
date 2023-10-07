/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-07 10:42:35
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-07 13:43:29
 * @Description: file content
 */
import 'package:flutter/material.dart';
import '../models/card_model.dart';

class CardItem extends StatefulWidget {
  CardItem(this.item);

  final Cards item;
  @override
  _CardItemState createState() {
    return _CardItemState();
  }
}

class _CardItemState extends State<CardItem> {
  _CardItemState();

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      onTap: () {
        // 跳转到商品详情
        print('点击了一件商品');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // 图片
          Container(
            width: double.infinity,
            color: Colors.grey,
            child: FadeInImage.assetNetwork(
              placeholder: 'images/banner.jpeg',
              image: widget.item.img, //这里是网络图片
              fit: BoxFit.fill,
            ),
          ),
          // 描述
          Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: Text(
                widget.item.des,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
          Container(
            // height: 80,
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Align(
              // alignment: Alignment.bottomLeft,
              heightFactor: 2,
              // widthFactor: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // 价钱和想要人数
                  Text("￥${widget.item.price.toString()}",
                      style: TextStyle(color: Colors.pink)),
                  Text("已售${widget.item.want.toString()}件",
                      style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
