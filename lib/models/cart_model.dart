/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-07 10:44:47
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-13 16:09:04
 * @Description: file content
 */
class CartModel {
    String code;
    String message;
    List<Datum> data;

    CartModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String goodsId;
    String goodsName;
    int count;
    double price;
    String images;

    Datum({
        required this.goodsId,
        required this.goodsName,
        required this.count,
        required this.price,
        required this.images,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        goodsId: json["goodsId"],
        goodsName: json["goodsName"],
        count: json["count"],
        price: json["price"]?.toDouble(),
        images: json["images"],
    );

    Map<String, dynamic> toJson() => {
        "goodsId": goodsId,
        "goodsName": goodsName,
        "count": count,
        "price": price,
        "images": images,
    };
}

