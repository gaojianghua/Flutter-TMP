/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-11 14:58:09
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-11 16:54:51
 * @Description: file content
 */

import 'package:flutter/services.dart';

class GoodsDetailLogic {
  // 获取商品详情
  static getGoodsDetail(String goodsId) async {
    return await rootBundle.loadString('data/goods_detail.json');
  }
}