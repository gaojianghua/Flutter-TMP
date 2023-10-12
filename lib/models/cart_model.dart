/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-07 10:44:47
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-12 15:05:40
 * @Description: file content
 */
class CartModel {
  late String goodsId;
  late String goodsName;
  late int count;
  late double price;
  late String images;

  CartModel(
      {required this.goodsId, required this.goodsName, required this.count, required this.price, required this.images});

  CartModel.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    count = json['count'];
    price = json['price'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['count'] = this.count;
    data['price'] = this.price;
    data['images'] = this.images;
    return data;
  }
}
