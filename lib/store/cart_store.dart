/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-12 15:48:27
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-18 13:51:44
 * @Description: file content
 */
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:decimal/decimal.dart';
import '../main_models/storage/index.dart';
import '../models/cart_model.dart';

class MyState {
  final List<Datum> cartList;
  Decimal allPrice;
  int allCount;
  bool allCheck;

  MyState({
    required this.cartList,
    required this.allPrice,
    required this.allCount,
    required this.allCheck,
  });
}

class CartStore extends Cubit<MyState> {
  CartStore()
      : super(MyState(
            cartList: [], allPrice: Decimal.parse('0.00'), allCount: 0, allCheck: false));

  void addGoods(Datum goods) async {
    var ps = PersistentStorage();
    bool isHave = false;
    state.cartList.forEach((item) {
      if (item.goodsId == goods.goodsId) {
        item.count = item.count + 1;
        isHave = true;
      }
    });
    if (!isHave) {
      state.cartList.add(goods);
    }
    await ps.setStorage('cartInfo', state.cartList);
    emit(MyState(
        cartList: state.cartList,
        allPrice: state.allPrice,
        allCount: state.allCount,
        allCheck: state.allCheck));
  }

  void remove() async {
    var ps = PersistentStorage();
    ps.remove('cartInfo');
    emit(MyState(
        cartList: [],
        allPrice: state.allPrice,
        allCount: state.allCount,
        allCheck: state.allCheck));
  }

  void getCartData(List<Datum> data) async {
    int tempCount = 0;
    Decimal tempPrice = Decimal.parse('0.00');
    data.forEach((item) {
      if (item.isChecked) {
        tempPrice += Decimal.parse(item.price.toString()) * Decimal.fromInt(item.count);
        tempCount += item.count;
      }
    });
    var ps = PersistentStorage();
    await ps.setStorage('cartInfo', data);
    emit(MyState(
        cartList: data,
        allPrice: tempPrice,
        allCount: tempCount,
        allCheck: false));
  }

  void deleteGoods(String id) async {
    int tempIndex = 0;
    state.cartList.forEach((item) {
      if (item.goodsId == id) {
        tempIndex = state.cartList.indexOf(item);
        if(item.isChecked) {
          state.allCount -= item.count;
          state.allPrice -= Decimal.parse(item.price.toString()) * Decimal.fromInt(item.count);
        }
      }
    });
    state.cartList.removeAt(tempIndex);
    if (state.cartList.length == 0) {
      state.allCheck = false;
    }
    var ps = PersistentStorage();
    await ps.setStorage('cartInfo', state.cartList);
    emit(MyState(
        cartList: state.cartList,
        allPrice: state.allPrice,
        allCount: state.allCount,
        allCheck: state.allCheck));
  }

  void changeCheck(Datum data, bool check) async {
    bool allBool = true;
    state.cartList.forEach((item) {
      if (item.goodsId == data.goodsId) {
        item.isChecked = check;
        if (check) {
          state.allCount += item.count;
          state.allPrice += Decimal.parse(item.price.toString()) * Decimal.fromInt(item.count);
        } else {
          state.allCount -= item.count;
          state.allPrice -= Decimal.parse(item.price.toString()) * Decimal.fromInt(item.count);
        }
      }
      if (!item.isChecked) {
        allBool = false;
      }
    });

    emit(MyState(
        cartList: state.cartList,
        allPrice: state.allPrice,
        allCount: state.allCount,
        allCheck: allBool));
  }

  void changeAllCheck(bool bool) async {
    if (bool) {
      state.allCount = 0;
      state.allPrice = Decimal.parse('0.00');
      state.cartList.forEach((item) {
        item.isChecked = bool;
        state.allCount += item.count;
        state.allPrice += Decimal.parse(item.price.toString()) * Decimal.fromInt(item.count);
      });
    } else {
      state.cartList.forEach((item) {
        item.isChecked = bool;
        state.allCount = 0;
        state.allPrice = Decimal.parse('0.00');
      });
    }

    emit(MyState(
        cartList: state.cartList,
        allPrice: state.allPrice,
        allCount: state.allCount,
        allCheck: bool));
  }

  void changeCount(Datum data, bool type) {
    int i = state.cartList.indexWhere((item) => item.goodsId == data.goodsId);
    type ? state.cartList[i].count++ : state.cartList[i].count--;
    if (type && state.cartList[i].isChecked) {
      state.allCount++;
      state.allPrice += Decimal.parse(state.cartList[i].price.toString());
    } else if (!type && state.cartList[i].isChecked) {
      state.allCount++;
      state.allPrice -= Decimal.parse(state.cartList[i].price.toString());
    }
    emit(MyState(
        cartList: state.cartList,
        allPrice: state.allPrice,
        allCount: state.allCount,
        allCheck: state.allCheck));
  }
}
