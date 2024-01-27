/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 11:25:27
 * @LastEditors: 高江华
 * @LastEditTime: 2024-01-27 18:00:10
 * @Description: file content
 */
import 'dart:convert';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../store/cart_store.dart';
import '../../models/cart_model.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    getCartData();
    super.initState();
  }

  late CartStore cartStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cartStore = BlocProvider.of<CartStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('购物车'),
        ),
        body: Stack(
          children: [
            EasyRefresh(
              child: Padding(
                  padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(80)),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) =>
                              cartItem(index),
                          childCount: cartStore.state.cartList.length,
                        ),
                      )
                    ],
                  )),
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 2));
                if (!mounted) {
                  return;
                }
                getCartData();
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: cartBottomSettlement(),
            )
          ],
        ));
  }

  Widget cartItem(i) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.black26)),
      ),
      child: Row(
        children: [
          cartItemCheck(i),
          cartItemImage(i),
          cartItemTitle(i),
          cartItemPrice(i)
        ],
      ),
    );
  }

  Widget cartItemCheck(i) {
    return Container(
      child: Checkbox(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        value: cartStore.state.cartList[i].isChecked,
        activeColor: Colors.red,
        onChanged: (bool) {
          cartStore.changeCheck(cartStore.state.cartList[i], bool!);
        },
      ),
    );
  }

  Widget cartItemImage(i) {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Image.network(
        cartStore.state.cartList[i].images,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget cartItemTitle(i) {
    return Container(
      width: ScreenUtil().setWidth(300),
      height: ScreenUtil().setWidth(150),
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            cartStore.state.cartList[i].goodsName,
          ),
          stepper(i)
        ],
      ),
    );
  }

  Widget cartItemPrice(i) {
    return Container(
      width: ScreenUtil().setWidth(150),
      height: ScreenUtil().setWidth(150),
      alignment: Alignment.topRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '¥${cartStore.state.cartList[i].price}',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(52.sp),
                color: Colors.red,
                fontWeight: FontWeight.bold),
          ),
          Container(
            child: InkWell(
              onTap: () {
                cartStore.deleteGoods(cartStore.state.cartList[i].goodsId);
              },
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

  Widget cartBottomSettlement() {
    return Container(
      padding: EdgeInsets.all(5),
      color: Colors.white,
      child: Row(
        children: [selectAllBtn(), allPriceArea(), settlementBtn()],
      ),
    );
  }

  Widget selectAllBtn() {
    return Container(
      child: Row(
        children: [
          Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            value: cartStore.state.allCheck,
            activeColor: Colors.red,
            onChanged: (bool) {
              cartStore.changeAllCheck(bool!);
            },
          ),
          InkWell(
            onTap: () {
              cartStore.changeAllCheck(!cartStore.state.allCheck);
            },
            child: Text('全选',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(50.sp), color: Colors.black)),
          )
        ],
      ),
    );
  }

  Widget allPriceArea() {
    return Container(
      width: ScreenUtil().setWidth(400),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '合计:',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(50.sp),
                  color: Colors.black,
                ),
                textAlign: TextAlign.right,
              ),
              Text(
                '￥ ${cartStore.state.allPrice}',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(56.sp),
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(40.sp),
                color: Colors.black38,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget settlementBtn() {
    return Container(
      width: ScreenUtil().setWidth(180),
      padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            '结算(${cartStore.state.allCount})',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget stepper(i) {
    return Container(
        width: ScreenUtil().setWidth(175),
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          stepperBtn(1, i),
          stepperCount(i),
          stepperBtn(2, i),
        ]));
  }

  Widget stepperBtn(int isBtn, i) {
    return InkWell(
      onTap: () {
        if (cartStore.state.cartList[i].count <= 1 && isBtn == 1) return;
        cartStore.changeCount(cartStore.state.cartList[i], isBtn == 1 ? false : true);
      },
      child: Container(
        width: ScreenUtil().setWidth(50),
        height: ScreenUtil().setHeight(40),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: isBtn == 1
              ? Border(right: BorderSide(width: 1, color: Colors.black12))
              : Border(left: BorderSide(width: 1, color: Colors.black12)),
          color: Colors.white,
        ),
        child: Text(isBtn == 1 ? '-' : '+'),
      ),
    );
  }

  Widget stepperCount(i) {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(40),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(
        '${cartStore.state.cartList[i].count}',
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
    CartModel cartData = CartModel.fromJson(jsonMap);
    cartStore.getCartData(cartData.data);
  }
}
