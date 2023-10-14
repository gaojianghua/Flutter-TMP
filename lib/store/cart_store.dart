/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-12 15:48:27
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-14 15:56:37
 * @Description: file content
 */
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main_models/storage/index.dart';
import '../models/cart_model.dart';

class CartStore extends Cubit<List<Datum>> {
  CartStore() : super([]);

  void save(goodsId, goodsName, count, price, images) async {
    var ps = PersistentStorage();
    List cartInfo = await ps.getStorage('cartInfo');
    List<dynamic> tempList = cartInfo.isEmpty ? [] : cartInfo;
    List<Datum> updateState = tempList.map((item) => Datum.fromJson(item)).toList();
    bool isHave = false;
    int ival = 0;
    updateState.forEach((item) {
      if (item.goodsId == goodsId) {
        updateState[ival].count = item.count + 1;
        isHave = true;
      }
      ival++;
    });
    if (!isHave) {
      Datum newGoods = Datum(goodsId:goodsId, goodsName:goodsName, count:count, price:price, images:images, isChecked: true);
      updateState.add(newGoods);
    }
    ps.setStorage('cartInfo', updateState);
    emit(updateState);
    print(updateState);
  }

  void remove() async {
    var ps = PersistentStorage();
    ps.remove('cartInfo');
    emit([]);
  }

  void getCartData(List<Datum> data) async {
    var ps = PersistentStorage();
    await ps.setStorage('cartInfo', data);
    emit(data);
  }

  deleteGoods(String id) async {
    var ps = PersistentStorage();
    List tempList = await ps.getStorage('cartInfo');
    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == id) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(delIndex);
    await ps.setStorage('cartInfo', tempList);
    List<Datum> state =
        tempList.map((item) => Datum.fromJson(item)).toList();
    getCartData(state);
  }
}
