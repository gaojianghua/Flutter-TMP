/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-09 17:03:30
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-09 17:10:55
 * @Description: file content
 */
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/category_model.dart';

class CategoryStore extends Cubit<List<BxMallSubDto>> {
  CategoryStore() : super([]);

  void setCategory(List<BxMallSubDto> category) {
    emit(category);
  }
}