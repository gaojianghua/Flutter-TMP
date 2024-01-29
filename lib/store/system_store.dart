/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-22 17:50:33
 * @LastEditors: 高江华
 * @LastEditTime: 2024-01-29 17:10:57
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SystemState {
  final int tabbarIndex;
  final Locale language;

  SystemState({
    required this.tabbarIndex,
    required this.language,
  });
}

class SystemStore extends Cubit<SystemState> {
  SystemStore() : super(SystemState(tabbarIndex: 0, language: Locale('en')));

  void setTabbarIndex(int i) => emit(SystemState(tabbarIndex: i, language: state.language));
  
  void setLanguage(Locale i) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString('lang_key', i.toString());
    emit(SystemState(tabbarIndex: state.tabbarIndex, language: i));
    
    print(state.language);
  }
}