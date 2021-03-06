import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gank_flutter/common/config/GankConfig.dart';
import 'package:gank_flutter/common/event/event_show_history_date.dart';
import 'package:gank_flutter/common/manager/cache_manager.dart';
import 'package:gank_flutter/redux/app_state.dart';
import 'package:gank_flutter/redux/redux_locale.dart';
import 'package:gank_flutter/redux/redux_theme.dart';
import 'package:gank_flutter/utils/commonUtils.dart';
import 'package:gank_flutter/utils/sp_utils.dart';
import 'package:redux/redux.dart';
import 'package:event_bus/event_bus.dart';

import 'favorite_manager.dart';

class AppManager {
  static EventBus eventBus = EventBus();

  /// 初始化App
  static initApp(context) async {
    try {
      // 主题
      String themeIndex = await SPUtils.get(GankConfig.THEME_COLOR);
      if (themeIndex != null && themeIndex.isNotEmpty) {
        await AppManager.switchThemeData(context, int.parse(themeIndex));
      }

      // 初始化缓存
      await CacheManager.init();
      // 初始化数据库
      await FavoriteManager.init();

      return true;
    } catch (e) {
      return false;
    }
  }

  /// 切换主题
  static switchThemeData(context, int index) async {
    Store store = StoreProvider.of<AppState>(context);

    List<Color> colors = CommonUtils.getThemeListColor();

    ThemeData themeData = new ThemeData(primaryColor: colors[index]);

    await SPUtils.save(GankConfig.THEME_COLOR, index.toString());
    store.dispatch(RefreshThemeDataAction(themeData));
  }

  /// 提示弹出日期选择框
  static notifyShowHistoryDate() {
    AppManager.eventBus.fire(ShowHistoryDateEvent());
  }

  static changeLocale(context, int index) async {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    Locale locale = store.state.platformLocal;
    switch (index) {
      case 0:
        locale = Locale('zh', 'CH');
        break;
      case 1:
        locale = Locale('en', 'US');
        break;
    }
    store.dispatch(RefreshLocaleAction(locale));
    await SPUtils.save(GankConfig.LOCALE, index.toString());
  }
}
