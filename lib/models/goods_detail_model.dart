class GoodsDetailModel {
  late String code;
  late String message;
  late DetailData data;

  GoodsDetailModel({required this.code, required this.message, required this.data});

  GoodsDetailModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = (json['data'] != null ? new DetailData.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data.toJson();
      return data;
  }
}

class DetailData {
  late GoodInfo goodInfo;
  late List<GoodComments> goodComments;
  late AdvertesPicture advertesPicture;

  DetailData({required this.goodInfo, required this.goodComments, required this.advertesPicture});

  DetailData.fromJson(Map<String, dynamic> json) {
    goodInfo = (json['goodInfo'] != null
        ? new GoodInfo.fromJson(json['goodInfo'])
        : null)!;
    if (json['goodComments'] != null) {
      goodComments = [];
      json['goodComments'].forEach((v) {
        goodComments.add(new GoodComments.fromJson(v));
      });
    }
    advertesPicture = (json['advertesPicture'] != null
        ? new AdvertesPicture.fromJson(json['advertesPicture'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodInfo'] = this.goodInfo.toJson();
    data['goodComments'] = this.goodComments.map((v) => v.toJson()).toList();
    data['advertesPicture'] = this.advertesPicture.toJson();
      return data;
  }
}

class GoodInfo {
  late String image5;
  late int amount;
  late String image3;
  late String image4;
  late String goodsId;
  late String isOnline;
  late String image1;
  late String image2;
  late String goodsSerialNumber;
  late double oriPrice;
  late double presentPrice;
  late String comPic;
  late int state;
  late String shopId;
  late String goodsName;
  late String goodsDetail;

  GoodInfo(
      {required this.image5,
      required this.amount,
      required this.image3,
      required this.image4,
      required this.goodsId,
      required this.isOnline,
      required this.image1,
      required this.image2,
      required this.goodsSerialNumber,
      required this.oriPrice,
      required this.presentPrice,
      required this.comPic,
      required this.state,
      required this.shopId,
      required this.goodsName,
      required this.goodsDetail});

  GoodInfo.fromJson(Map<String, dynamic> json) {
    image5 = json['image5'];
    amount = json['amount'];
    image3 = json['image3'];
    image4 = json['image4'];
    goodsId = json['goodsId'];
    isOnline = json['isOnline'];
    image1 = json['image1'];
    image2 = json['image2'];
    goodsSerialNumber = json['goodsSerialNumber'];
    oriPrice = json['oriPrice'];
    presentPrice = json['presentPrice'];
    comPic = json['comPic'];
    state = json['state'];
    shopId = json['shopId'];
    goodsName = json['goodsName'];
    goodsDetail = json['goodsDetail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image5'] = this.image5;
    data['amount'] = this.amount;
    data['image3'] = this.image3;
    data['image4'] = this.image4;
    data['goodsId'] = this.goodsId;
    data['isOnline'] = this.isOnline;
    data['image1'] = this.image1;
    data['image2'] = this.image2;
    data['goodsSerialNumber'] = this.goodsSerialNumber;
    data['oriPrice'] = this.oriPrice;
    data['presentPrice'] = this.presentPrice;
    data['comPic'] = this.comPic;
    data['state'] = this.state;
    data['shopId'] = this.shopId;
    data['goodsName'] = this.goodsName;
    data['goodsDetail'] = this.goodsDetail;
    return data;
  }
}

class GoodComments {
  late int sCORE;
  late String comments;
  late String userName;
  late int discussTime;

  GoodComments({required this.sCORE, required this.comments, required this.userName, required this.discussTime});

  GoodComments.fromJson(Map<String, dynamic> json) {
    sCORE = json['SCORE'];
    comments = json['comments'];
    userName = json['userName'];
    discussTime = json['discussTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SCORE'] = this.sCORE;
    data['comments'] = this.comments;
    data['userName'] = this.userName;
    data['discussTime'] = this.discussTime;
    return data;
  }
}

class AdvertesPicture {
  late String pICTUREADDRESS;
  late String tOPLACE;

  AdvertesPicture({required this.pICTUREADDRESS, required this.tOPLACE});

  AdvertesPicture.fromJson(Map<String, dynamic> json) {
    pICTUREADDRESS = json['PICTURE_ADDRESS'];
    tOPLACE = json['TO_PLACE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PICTURE_ADDRESS'] = this.pICTUREADDRESS;
    data['TO_PLACE'] = this.tOPLACE;
    return data;
  }
}
