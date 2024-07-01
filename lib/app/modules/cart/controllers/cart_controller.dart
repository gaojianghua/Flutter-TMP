/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-13 20:04:09
 * @LastEditors: 高江华
 * @LastEditTime: 2024-04-07 22:49:09
 * @Description: file content
 */
import 'package:get/get.dart';
import 'package:flutter_tmp/app/services/cartServices.dart';
import 'package:flutter_tmp/app/services/storage.dart';
import 'package:flutter_tmp/app/services/userServices.dart';

class CartController extends GetxController {

  RxList cartList = [].obs;
  RxBool allChecked = false.obs;
  RxBool isEdit = false.obs;
  
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // 获取购物车数据
  getCartList() async {
    var tempList = await CartServices.getCartList();
    cartList.value = tempList;
    allChecked.value = isCheckedAll();
    update();
  }
  // 增加数量
  void incCartNum(cartItem) {
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if(cartList[i]["_id"] == cartItem["_id"] && cartList[i]["selectAttr"] == cartItem["selectAttr"]) {
        cartList[i]["count"]++;
      }
      tempList.add(cartList[i]);
    }
    cartList.value = tempList;
    CartServices.setCartList(tempList);
    update();
  }
  // 减少数量
  void decCartNum(cartItem) {
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if(cartList[i]["_id"] == cartItem["_id"] && cartList[i]["selectAttr"] == cartItem["selectAttr"]) {
        if (cartList[i]["count"] > 1) {
          cartList[i]["count"]--;
        }else{
          Get.snackbar("提示", "商品数量已达最小值！");
        }
      }
      tempList.add(cartList[i]);
    }
    cartList.value = tempList;
    CartServices.setCartList(tempList);
    update();
  }
  // 选中商品
  void checkCartItem(cartItem) {
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if(cartList[i]["_id"] == cartItem["_id"] && cartList[i]["selectAttr"] == cartItem["selectAttr"]) {
        cartList[i]["checked"] = !cartList[i]["checked"];
      }
      tempList.add(cartList[i]);
    }
    cartList.value = tempList;
    allChecked.value = isCheckedAll();
    CartServices.setCartList(tempList);
    update();
  }
  // 全选变化
  void checkAllCartItem(value) {
    allChecked.value = value;
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      cartList[i]["checked"] = value;
      tempList.add(cartList[i]);
    }
    cartList.value = tempList;
    CartServices.setCartList(tempList);
    update();
  }
  // 判断是否全选
  bool isCheckedAll() {
    if (cartList.isNotEmpty) {
      for (var i = 0; i < cartList.length; i++) {
        if (cartList[i]["checked"] == false) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  // 获取要结算的商品
  getCheckOutData() {
    List tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if (cartList[i]["checked"] == true) {
        tempList.add(cartList[i]);
      }
    }
    return tempList;
  }

  // 判断用户是否登录
  Future<bool> isLogin() async {
    return await UserServices.getUserLoginState();
  }

  checkout() async {
    bool loginStatus = await isLogin();
    List checkListData = getCheckOutData();
    if (loginStatus) {
      if (checkListData.isNotEmpty) {
        Storage.setData("checkoutList", checkListData);
        Get.toNamed("/checkout");
      }else {
        Get.snackbar("提示", "购物车中没有要结算的商品");
      }
    }else {
      Get.toNamed("code-login-step-one");
      Get.snackbar("提示", "您还没有登录，请先登录");
    }
  }

  //改变edit属性
  changeEditState(){
    isEdit.value=!isEdit.value;
    update();
  }
  //删除购物车数据

  deleteCartData(){
    List tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if (cartList[i]["checked"] == false) {
        tempList.add(cartList[i]);
      }
    }    
    //把没有选中的商品保存在cart里面
    cartList.value = tempList;
    CartServices.setCartList(tempList);
    update();

  }
}
