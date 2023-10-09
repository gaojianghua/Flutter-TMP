class CategoryModel {
  late String code;
  late String message;
  late List<Data> data;

  CategoryModel({required this.code, required this.message, required this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  late String mallCategoryId;
  late String mallCategoryName;
  late List<BxMallSubDto> bxMallSubDto;
  late String? comments;
  late String image;

  Data(
      {required this.mallCategoryId,
      required this.mallCategoryName,
      required this.bxMallSubDto,
      this.comments,
      required this.image});

  Data.fromJson(Map<String, dynamic> json) {
    mallCategoryId = json['mallCategoryId'];
    mallCategoryName = json['mallCategoryName'];
    if (json['bxMallSubDto'] != null) {
      bxMallSubDto = [];
      json['bxMallSubDto'].forEach((v) {
        bxMallSubDto.add(new BxMallSubDto.fromJson(v));
      });
    }
    comments = json['comments'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallCategoryName'] = this.mallCategoryName;
    data['bxMallSubDto'] = this.bxMallSubDto.map((v) => v.toJson()).toList();
    data['comments'] = this.comments;
    data['image'] = this.image;
    return data;
  }
}

class BxMallSubDto {
  late String mallSubId;
  late String mallCategoryId;
  late String mallSubName;
  late String? comments;

  BxMallSubDto(
      {required this.mallSubId, required this.mallCategoryId, required this.mallSubName, required this.comments});

  BxMallSubDto.fromJson(Map<String, dynamic> json) {
    mallSubId = json['mallSubId'];
    mallCategoryId = json['mallCategoryId'];
    mallSubName = json['mallSubName'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallSubId'] = this.mallSubId;
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallSubName'] = this.mallSubName;
    data['comments'] = this.comments;
    return data;
  }
}
