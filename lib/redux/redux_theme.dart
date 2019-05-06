import 'package:flutter/material.dart';
import 'package:gank_flutter/common/github_user.dart';
import 'package:redux/redux.dart';

/// redux 的 combineReducers, 通过 TypedReducer 将 UpdateUserAction 与 reducers 关联起来
final combineThemeDataReducer = combineReducers<ThemeData>(

    ///将 Action 、处理 Action 的方法、State 绑定
    [TypedReducer<ThemeData, RefreshThemeDataAction>(_refresh)]);

/// 如果有 UpdateUserAction 发起一个请求时
/// 就会调用到 _updateLoaded
/// _updateLoaded 这里接受一个新的userInfo，并返回
ThemeData _refresh(ThemeData themeData, RefreshThemeDataAction action) {
  themeData = action.themeData;
  return themeData;
}

///定一个 UpdateUserAction ，用于发起 userInfo 的的改变
///类名随你喜欢定义，只要通过上面TypedReducer绑定就好
class RefreshThemeDataAction {
  final ThemeData themeData;

  RefreshThemeDataAction(this.themeData);
}
