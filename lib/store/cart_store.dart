/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-12 15:48:27
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-16 11:55:18
 * @Description: file content
 */
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main_models/storage/index.dart';
import '../models/cart_model.dart';

class CartStore extends Bloc<List<Datum>, List<Datum>> {
  CartStore() : super([]) {
    on<List<Datum>>(_onNewList);
  }

  Future<void> _onNewList(List<Datum> event, Emitter<List<Datum>> emit) async {
    emit(event);
  }

  void addGoods(Datum goods) {
    final updatedState = List<Datum>.from(state)..add(goods);
    add(updatedState);
  }

  void remove() async {
    var ps = PersistentStorage();
    ps.remove('cartInfo');
    add([]);
  }

  void getCartData(List<Datum> data) async {
    var ps = PersistentStorage();
    final updatedState = List<Datum>.from(state)..addAll(data);
    await ps.setStorage('cartInfo', updatedState);
    add(updatedState);
  }

  void deleteGoods(String id) async {
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
    List<Datum> updatedState =
        tempList.map((item) => Datum.fromJson(item)).toList();
    add(updatedState);
  }
}