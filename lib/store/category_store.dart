/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-09 17:03:30
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-10 16:38:08
 * @Description: file content
 */
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/category_model.dart';

class MyState {
  final List<BxMallSubDto> list;
  final int childIndex;
  final String categoryId;
  final String categorySubId;
  final int page;
  final String? noMoreText;

  MyState(
    {
      required this.list,
      required this.childIndex,
      required this.categoryId,
      required this.categorySubId,
      required this.page,
      this.noMoreText
    }
  );
}

class CategoryStore extends Cubit<MyState> {
  CategoryStore(): super(
    MyState(
      list: [],
      childIndex: 0,
      categoryId: '4',
      categorySubId: '0',
      page: 1,
      noMoreText: ''
    )
  );

  void setCategory(List<BxMallSubDto> category, String i) {
    BxMallSubDto all = BxMallSubDto(
        mallSubId: '', mallCategoryId: '', mallSubName: '', comments: '');
    all.mallSubId = '00';
    all.mallSubName = '全部';
    all.mallCategoryId = '00';
    all.comments = '';
    List<BxMallSubDto> list = [all];
    list.addAll(category);
    emit(
      MyState(
        list: list, 
        childIndex: 0, 
        categoryId: i, 
        categorySubId: '0',
        page: 1,
        noMoreText: ''
      )
    );
  }

  void changeChildIndex(int i, String id) {
    emit(
      MyState(
        list: state.list,
        childIndex: i,
        categoryId: state.categoryId,
        categorySubId: id,
        page: 1,
        noMoreText: ''
      )
    );
  }

  addPage() {
    emit(
      MyState(
        list: state.list,
        childIndex: state.childIndex,
        categoryId: state.categoryId,
        categorySubId: state.categorySubId,
        page: state.page + 1,
        noMoreText: ''
      )
    );
  }

  changeNoMoreText(String text) {
    emit(
      MyState(
        list: state.list,
        childIndex: state.childIndex,
        categoryId: state.categoryId,
        categorySubId: state.categorySubId,
        page: state.page,
        noMoreText: text
      )
    );
  }
}
