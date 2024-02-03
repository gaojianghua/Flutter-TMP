/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-12 15:48:27
 * @LastEditors: 高江华
 * @LastEditTime: 2024-01-28 16:30:37
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
  int goodsNum;

  MyState({
    required this.cartList,
    required this.allPrice,
    required this.allCount,
    required this.allCheck,
    required this.goodsNum,
  });

  @override
  String toString() {
    return 'MyState{cartList: $cartList, allPrice: $allPrice, allCount: $allCount, allCheck: $allCheck}';
  }
}

class CartStore extends Cubit<MyState> {
  CartStore()
      : super(MyState(
            cartList: [], allPrice: Decimal.parse('0.00'), allCount: 0, allCheck: false, goodsNum: 0));

  void addGoods(Datum goods) {
    bool isHave = false;
    state.goodsNum++;
    state.cartList.forEach((item) {
      if (item.goodsId == goods.goodsId) {
        item.count = item.count + 1;
        isHave = true;
      }
    });
    if (!isHave) {
      state.cartList.add(goods);
      state.allCheck = false;
    }
    
    updateCartList(state.cartList, state.allPrice, state.allCount, state.allCheck, state.goodsNum);
  }

  void remove() {
    var ps = PersistentStorage();
    ps.remove('cartInfo');
    updateCartList([], Decimal.parse('0.00'), 0, false, 0);
  }

  void getCartData(List<Datum> data) {
    int tempCount = 0;
    int goodNum = 0;
    Decimal tempPrice = Decimal.parse('0.00');
    data.forEach((item) {
      if (item.isChecked) {
        tempPrice += Decimal.parse(item.price.toString()) * Decimal.fromInt(item.count);
        tempCount += item.count;
      }
      goodNum += item.count;
    });
    print(goodNum);
    var ps = PersistentStorage();
    ps.setStorage('cartInfo', data);
    emit(MyState(
        cartList: data,
        allPrice: tempPrice,
        allCount: tempCount,
        allCheck: false, 
        goodsNum: goodNum));
  }

  void deleteGoods(String id) {
    int tempIndex = 0;
    state.cartList.forEach((item) {
      if (item.goodsId == id) {
        tempIndex = state.cartList.indexOf(item);
        if(item.isChecked) {
          state.allCount -= item.count;
          state.allPrice -= Decimal.parse(item.price.toString()) * Decimal.fromInt(item.count);
        }
        state.goodsNum -= item.count;
      }
    });
    state.cartList.removeAt(tempIndex);
    if (state.cartList.length == 0) {
      state.allCheck = false;
    }
    updateCartList(state.cartList, state.allPrice, state.allCount, state.allCheck, state.goodsNum);
  }

  void changeCheck(Datum data, bool check) {
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

    updateCartList(state.cartList, state.allPrice, state.allCount, allBool, state.goodsNum);
  }

  void changeAllCheck(bool bool) {
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

    updateCartList(state.cartList, state.allPrice, state.allCount, bool, state.goodsNum);
  }

  void changeCount(Datum data, bool type) {
    print(data);
    int i = state.cartList.indexWhere((item) => item.goodsId == data.goodsId);
    type ? state.cartList[i].count++ : state.cartList[i].count--;
    type ? state.goodsNum++ : state.goodsNum--;
    if (type && state.cartList[i].isChecked) {
      state.allCount++;
      state.allPrice += Decimal.parse(state.cartList[i].price.toString());
    } else if (!type && state.cartList[i].isChecked) {
      state.allCount++;
      state.allPrice -= Decimal.parse(state.cartList[i].price.toString());
    }
    print(state.goodsNum);
    updateCartList(state.cartList, state.allPrice, state.allCount, state.allCheck, state.goodsNum);
  }

  void updateCartList(List<Datum> cartList, Decimal allPrice, int allCount, bool allCheck, int goodsNum) {
    var ps = PersistentStorage();
    ps.setStorage('cartInfo', cartList);
    emit(MyState(
      cartList: cartList,
      allPrice: allPrice,
      allCount: allCount,
      allCheck: allCheck,
      goodsNum: goodsNum
    ));
  }
}
