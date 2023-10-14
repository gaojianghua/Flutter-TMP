/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-10 13:34:13
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-14 17:38:38
 * @Description: file content
 */
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/category_goods_list.dart';

class CategoryGoodsListStore extends Cubit<List<GoodsData>> {
  CategoryGoodsListStore() : super([]);

  void setCategoryGoodsList(List<GoodsData> goodsList) {
    emit(goodsList);
  }

  void setMoreGoodsList(List<GoodsData> goodsList) {
    state.addAll(goodsList);
    emit(state);
  }
}