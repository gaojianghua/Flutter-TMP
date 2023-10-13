class HomeModel {
  late int code;
  late HomeData data;
  late String msg;

  HomeModel({required this.code, required this.data, required this.msg});

  HomeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = (json['data'] != null ? new HomeData.fromJson(json['data']) : null)!;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['data'] = this.data.toJson();
      data['msg'] = this.msg;
    return data;
  }
}

class HomeData {
  late List<Slides> slides;
  late List<Menus> menus;
  late ShopInfo shopInfo;
  late List<GoodsList> goodsList;
  late String floorGoodsTitleOne;
  late List<FloorGoodsListOne> floorGoodsListOne;
  late String floorGoodsTitleTwo;
  late List<FloorGoodsListOne> floorGoodsListTwo;
  late List<Cards> cards;

  HomeData(
      {required this.slides,
      required this.menus,
      required this.shopInfo,
      required this.goodsList,
      required this.floorGoodsTitleOne,
      required this.floorGoodsListOne,
      required this.floorGoodsTitleTwo,
      required this.floorGoodsListTwo,
      required this.cards});

  HomeData.fromJson(Map<String, dynamic> json) {
    if (json['slides'] != null) {
      slides = [];
      json['slides'].forEach((v) {
        slides.add(new Slides.fromJson(v));
      });
    }
    if (json['menus'] != null) {
      menus = [];
      json['menus'].forEach((v) {
        menus.add(new Menus.fromJson(v));
      });
    }
    shopInfo = (json['shopInfo'] != null
        ? new ShopInfo.fromJson(json['shopInfo'])
        : null)!;
    if (json['goodsList'] != null) {
      goodsList = [];
      json['goodsList'].forEach((v) {
        goodsList.add(new GoodsList.fromJson(v));
      });
    }
    floorGoodsTitleOne = json['floorGoodsTitleOne'];
    if (json['floorGoodsListOne'] != null) {
      floorGoodsListOne = [];
      json['floorGoodsListOne'].forEach((v) {
        floorGoodsListOne.add(new FloorGoodsListOne.fromJson(v));
      });
    }
    floorGoodsTitleTwo = json['floorGoodsTitleTwo'];
    if (json['floorGoodsListTwo'] != null) {
      floorGoodsListTwo = [];
      json['floorGoodsListTwo'].forEach((v) {
        floorGoodsListTwo.add(new FloorGoodsListOne.fromJson(v));
      });
    }
    if (json['cards'] != null) {
      cards = [];
      json['cards'].forEach((v) {
        cards.add(new Cards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slides'] = this.slides.map((v) => v.toJson()).toList();
    data['menus'] = this.menus.map((v) => v.toJson()).toList();
    data['shopInfo'] = this.shopInfo.toJson();
    data['goodsList'] = this.goodsList.map((v) => v.toJson()).toList();
      data['floorGoodsTitleOne'] = this.floorGoodsTitleOne;
    data['floorGoodsListOne'] =
        this.floorGoodsListOne.map((v) => v.toJson()).toList();
      data['floorGoodsTitleTwo'] = this.floorGoodsTitleTwo;
    data['floorGoodsListTwo'] =
        this.floorGoodsListTwo.map((v) => v.toJson()).toList();
    data['cards'] = this.cards.map((v) => v.toJson()).toList();
      return data;
  }
}

class Slides {
  late String url;
  late String goodsId;

  Slides({required this.url, required this.goodsId});

  Slides.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    goodsId = json['goodsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['goodsId'] = this.goodsId;
    return data;
  }
}

class Menus {
  late String name;
  late String image;

  Menus({required this.name, required this.image});

  Menus.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class ShopInfo {
  late String leaderImage;
  late String leaderPhone;

  ShopInfo({required this.leaderImage, required this.leaderPhone});

  ShopInfo.fromJson(Map<String, dynamic> json) {
    leaderImage = json['leaderImage'];
    leaderPhone = json['leaderPhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leaderImage'] = this.leaderImage;
    data['leaderPhone'] = this.leaderPhone;
    return data;
  }
}

class GoodsList {
  late double mallPrice;
  late String image;
  late double price;
  late String goodsId;

  GoodsList({required this.mallPrice, required this.image, required this.price, required this.goodsId});

  GoodsList.fromJson(Map<String, dynamic> json) {
    mallPrice = json['mallPrice'];
    image = json['image'];
    price = json['price'];
    goodsId = json['goodsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallPrice'] = this.mallPrice;
    data['image'] = this.image;
    data['price'] = this.price;
    data['goodsId'] = this.goodsId;
    return data;
  }
}

class FloorGoodsListOne {
  late String image;
  late String goodsId;

  FloorGoodsListOne({required this.image, required this.goodsId});

  FloorGoodsListOne.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    goodsId = json['goodsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['goodsId'] = this.goodsId;
    return data;
  }
}

class Cards {
  late String img;
  late String des;
  late double price;
  late double mallPrice;
  late int want;
  late String username;
  late String goodsId;

  Cards(
      {required this.img,
      required this.des,
      required this.price,
      required this.mallPrice,
      required this.want,
      required this.username,
      required this.goodsId});

  Cards.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    des = json['des'];
    price = json['price'];
    mallPrice = json['mallPrice'];
    want = json['want'];
    username = json['username'];
    goodsId = json['goodsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['des'] = this.des;
    data['price'] = this.price;
    data['mallPrice'] = this.mallPrice;
    data['want'] = this.want;
    data['username'] = this.username;
    data['goodsId'] = this.goodsId;
    return data;
  }
}
