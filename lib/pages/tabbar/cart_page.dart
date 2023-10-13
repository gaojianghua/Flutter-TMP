/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 11:25:27
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-13 17:32:20
 * @Description: file content
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/store/cart_store.dart';

import '../../models/cart_model.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    getCartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('购物车'),
        ),
        body: BlocBuilder<CartStore, List<Datum>>(builder: (context, state) {
          return state.isNotEmpty
              ? ListView.builder(
                  itemCount: state.length,
                  itemBuilder: (centext, index) => cartItem(state[index]),
                )
              : Text('购物车为空');
        }));
  }

  Widget cartItem(Datum item) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12)),
      ),
      child: Row(
        children: [
          cartItemCheck(item),
          cartItemImage(item),
          cartItemTitle(item),
          cartItemPrice(item)
        ],
      ),
    );
  }

  Widget cartItemCheck(Datum item) {
    return Container(
      child: Checkbox(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        value: true,
        activeColor: Colors.red,
        onChanged: (bool) {},
      ),
    );
  }

  Widget cartItemImage(Datum item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Image.network(
        item.images,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget cartItemTitle(Datum item) {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.goodsName,
          )
        ],
      ),
    );
  }

  Widget cartItemPrice(Datum item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.topRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '¥${item.price}',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(52.sp),
                color: Colors.red,
                fontWeight: FontWeight.bold),
          ),
          Container(
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.delete_forever,
                size: ScreenUtil().setSp(100.sp),
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget cartBottomSettlement(Datum item) {
    return Container(
      padding: EdgeInsets.all(5),
      color: Colors.white,
      child: Row(
        children: [],
      ),
    );
  }

  Widget selectAllBtn(Datum item) {
    return Container(
      child: Row(
        children: [
          Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            value: true,
            activeColor: Colors.red,
            onChanged: (bool) {},
          ),
          Text('全选',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(60.sp), color: Colors.black))
        ],
      ),
    );
  }

  getCartData() async {
    String jsonString = await rootBundle.loadString('data/cart.json');
    late Map<String, dynamic> jsonMap;
    try {
      jsonMap = await json.decode(jsonString);
    } catch (e) {
      print('JSON decode error: $e');
    }
    if (jsonMap.containsKey('data')) {
      try {
        CartModel cartData = CartModel.fromJson(jsonMap);
        // 使用 homeData 进行后续操作
        context.read<CartStore>().getCartData(cartData.data);
      } catch (e) {
        print('Error in processing homeData: $e');
      }
    } else {
      print('Invalid JSON data or missing "data" key');
    }
  }
}
