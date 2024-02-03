/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-13 09:40:30
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-13 12:46:24
 * @Description: file content
 */
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/home_model.dart';

class HomeStore extends Cubit<HomeData> {
  HomeStore()
      : super(HomeData(
            slides: [],
            menus: [],
            shopInfo: ShopInfo(leaderImage: '', leaderPhone: ''),
            goodsList: [],
            floorGoodsTitleOne: '',
            floorGoodsListOne: [],
            floorGoodsTitleTwo: '',
            floorGoodsListTwo: [],
            cards: []));

  // 为方法添加异常处理代码
  void setHomeData(HomeData data) {
    try {
      state
        ..slides = data.slides
        ..menus = data.menus
        ..shopInfo = data.shopInfo
        ..goodsList = data.goodsList
        ..floorGoodsTitleOne = data.floorGoodsTitleOne
        ..floorGoodsListOne = data.floorGoodsListOne
        ..floorGoodsTitleTwo = data.floorGoodsTitleTwo
        ..floorGoodsListTwo = data.floorGoodsListTwo
        ..cards = data.cards;
      emit(state);
    } catch (e) {
      print('setHomeData error: $e');
    }
  }
}
