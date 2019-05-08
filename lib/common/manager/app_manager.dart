import 'dart:ui';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:gank_flutter/common/config/GankConfig.dart';
import 'package:gank_flutter/common/manager/cache_manager.dart';
import 'package:gank_flutter/redux/app_state.dart';
import 'package:gank_flutter/redux/redux_locale.dart';
import 'package:gank_flutter/utils/sp_utils.dart';
import 'package:redux/redux.dart';

class AppManager {

  /// 初始化App
  static initApp(context) async{
    try{

      // 初始化缓存
      await CacheManager.init();
    }catch(e){

    }
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
