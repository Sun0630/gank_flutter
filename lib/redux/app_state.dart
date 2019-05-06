import 'package:flutter/material.dart';
import 'package:gank_flutter/common/github_user.dart';
import 'package:gank_flutter/redux/redux_locale.dart';
import 'package:gank_flutter/redux/redux_theme.dart';
import 'package:gank_flutter/redux/redux_user.dart';

/// 全局Redux store对象
class AppState {
  /// 用户信息
  User userInfo;

  /// 主题信息
  ThemeData themeData;

  /// 语言
  Locale locale;

  /// 当前平台默认语言
  Locale platformLocal;

  AppState({this.userInfo, this.themeData, this.locale, this.platformLocal});
}

/// 创建Reducer
AppState appReducer(AppState state, action) {
  return AppState(
    userInfo: combineUserReducer(state.userInfo, action),
    themeData: combineThemeDataReducer(state.themeData,action),
    locale: combineLocaleReducer(state.locale,action)
  );
}
