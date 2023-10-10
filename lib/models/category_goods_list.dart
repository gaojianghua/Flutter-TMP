/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-10 11:30:31
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-10 11:34:46
 * @Description: file content
 */
class CategoryGoodsListModel {
  late String code;
  late String message;
  late List<GoodsData> data;

  CategoryGoodsListModel({required this.code, required this.message, required this.data});

  CategoryGoodsListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new GoodsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data.map((v) => v.toJson()).toList();
      return data;
  }
}

class GoodsData {
  late String image;
  late double oriPrice;
  late double presentPrice;
  late String goodsName;
  late String goodsId;

  GoodsData(
      {
      required this.image,
      required this.oriPrice,
      required this.presentPrice,
      required this.goodsName,
      required this.goodsId});

  GoodsData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    oriPrice = json['oriPrice'];
    presentPrice = json['presentPrice'];
    goodsName = json['goodsName'];
    goodsId = json['goodsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['oriPrice'] = this.oriPrice;
    data['presentPrice'] = this.presentPrice;
    data['goodsName'] = this.goodsName;
    data['goodsId'] = this.goodsId;
    return data;
  }
}
