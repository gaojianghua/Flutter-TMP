/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-12 15:48:27
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-13 16:24:13
 * @Description: file content
 */
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_model.dart';

class CartStore extends Cubit<List<Datum>> {
  CartStore() : super([]);

  void save(goodsId, goodsName, count, price, images) async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String? cartInfo = prefs.getString('cartInfo');
    var temp  = cartInfo == null ? [] : json.decode(cartInfo.toString());
    List<Datum> state = (temp as List).cast();
    bool isHave = false;
    int ival = 0;
    state.forEach((item){
      if(item.goodsId == goodsId){
        state[ival].count = item.count + 1;
        isHave = true;
      }
      ival++;
    });
    if(!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId, 'goodsName': goodsName, 'count': count, 'price': price, 'images': images
      };
      state.add(newGoods as Datum);
    }
    cartInfo = json.encode(state).toString();
    prefs.setString('cartInfo', cartInfo);
    emit(state);
  }

  void remove() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.remove('cartInfo');
    emit([]);
  }

  void getCartData(List<Datum> data) {
    try {
      state.addAll(data);
      emit(state);
    } catch (e) {
      print('setHomeData error: $e');
    }
  }
}