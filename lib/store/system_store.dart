/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-22 17:50:33
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-18 11:01:40
 * @Description: file content
 */
import 'package:flutter_bloc/flutter_bloc.dart';

class SystemState {
  final int tabbarIndex;

  SystemState({
    required this.tabbarIndex
  });
}

class SystemStore extends Cubit<SystemState> {
  SystemStore() : super(SystemState(tabbarIndex: 0));

  void setTabbarIndex(int i) => emit(SystemState(tabbarIndex: i));
}