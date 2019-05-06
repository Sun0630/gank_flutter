import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gank_flutter/common/constant/colors.dart';
import 'package:gank_flutter/redux/app_state.dart';
import 'package:gank_flutter/ui/home_page.dart';
import 'package:gank_flutter/ui/splash_page.dart';
import 'package:redux/redux.dart';

void main() => runApp(GankApp());

class GankApp extends StatelessWidget {
// 初始化 Redux 的 Store
  final store = Store<AppState>(
    appReducer,
    // 初始化数据
    initialState: AppState(
        userInfo: null,
        themeData: new ThemeData(
            primaryColor: AppColors.PRIMARY_DEFAULT_COLOR,
            platform: TargetPlatform.android),
        locale: Locale('zh', 'CH')),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreBuilder<AppState>(builder: (context, store) {
        return MaterialApp(
          theme: store.state.themeData,
//          locale: store.state.locale,
//          supportedLocales: [store.state.locale],
//          initialRoute: SplashPage.ROUTE_NAME,
          routes: {
            SplashPage.ROUTE_NAME: (context) => SplashPage(),
            HomePage.ROUTE_NAME:(context)=>HomePage(),
          },
        );
      }),
    );
  }
}
