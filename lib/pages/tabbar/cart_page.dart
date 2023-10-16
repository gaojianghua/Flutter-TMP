/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 11:25:27
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-16 17:21:57
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../main_models/storage/index.dart';
import '../../store/cart_store.dart';
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
        body: BlocBuilder<CartStore, List<Datum>>(builder: (context, list) {
          return list.length > 0
              ? Stack(
                  children: [
                    ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (centext, index) => cartItem(list[index]),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: cartBottomSettlement(),
                    )
                  ],
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
          cartItemCheck(context, item),
          cartItemImage(item),
          cartItemTitle(item),
          cartItemPrice(item)
        ],
      ),
    );
  }

  Widget cartItemCheck(BuildContext c, Datum item) {
    return Container(
      child: Checkbox(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        value: item.isChecked,
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
              onTap: () {
                context.read<CartStore>().deleteGoods(item.goodsId);
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

  Widget allPriceArea() {
    return Container(
      width: ScreenUtil().setWidth(410),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(230),
                child: Text(
                  '合计:',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(60.sp),
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(180),
                child: Text(
                  '￥ 1992.00',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(60.sp),
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(410),
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
      width: ScreenUtil().setWidth(160),
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
            '结算',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  getCartData() async {
    // String jsonString = await rootBundle.loadString('data/cart.json');
    // late Map<String, dynamic> jsonMap;
    // try {
    //   jsonMap = await json.decode(jsonString);
    // } catch (e) {
    //   print('JSON decode error: $e');
    // }
    // // CartModel cartData = CartModel.fromJson(jsonMap);
    var ps = PersistentStorage();
    List<dynamic> tempList = await ps.getStorage('cartInfo');
    List<Datum> updatedState =
        tempList.map((item) => Datum.fromJson(item)).toList();
    context.read<CartStore>().getCartData(updatedState);
  }
}
