/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-07 10:44:47
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-07 11:24:40
 * @Description: file content
 */
class CardModel {
  late List<Cards> _cards;

  CardModel({List<Cards>? cards}) {
    this._cards = cards!;
  }

  List<Cards> get cards => _cards;
  set cards(List<Cards> cards) => _cards = cards;

  CardModel.fromJson(Map<String, dynamic> json) {
    if (json['cards'] != null) {
      List<Cards> _cards = [];
      json['cards'].forEach((v) {
        _cards.add(new Cards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cards'] = this._cards.map((v) => v.toJson()).toList();
      return data;
  }
}

class Cards {
  late String _img;
  late String _des;
  late double _price;
  late int _want;
  late String _username;

  Cards({required String img, required String des, required double price, required int want, required String username}) {
    this._img = img;
    this._des = des;
    this._price = price;
    this._want = want;
    this._username = username;
  }

  String get img => _img;
  set img(String img) => _img = img;
  String get des => _des;
  set des(String des) => _des = des;
  double get price => _price;
  set price(double price) => _price = price;
  int get want => _want;
  set want(int want) => _want = want;
  String get username => _username;
  set username(String username) => _username = username;

  Cards.fromJson(Map<String, dynamic> json) {
    _img = json['img'];
    _des = json['des'];
    _price = json['price'];
    _want = json['want'];
    _username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this._img;
    data['des'] = this._des;
    data['price'] = this._price;
    data['want'] = this._want;
    data['username'] = this._username;
    return data;
  }
}