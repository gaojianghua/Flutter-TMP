/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2024-03-08 15:37:44
 * @LastEditors: 高江华
 * @LastEditTime: 2024-03-18 17:40:04
 * @Description: file content
 */
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter{

  static width(num v){
    return v.w;
  }
  static height(num v){
    return v.h;
  }
  static fontSize(num v){
    return v.sp;
  }
  static getScreenWidth(){
      // return  ScreenUtil().screenWidth;
      return 1.sw;
  }
  static getScreenHeight  (){
      // return  ScreenUtil().screenHeight;
      return 1.sh;
  }

  static getStatusHeight() {
    return ScreenUtil().statusBarHeight;
  }
}