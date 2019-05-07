import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gank_flutter/common/constant/colors.dart';
import 'package:gank_flutter/common/localization/gank_localization_delegate.dart';
import 'package:gank_flutter/common/localization/gank_localizations_wrapper.dart';
import 'package:gank_flutter/redux/app_state.dart';
import 'package:gank_flutter/ui/page/home_page.dart';
import 'package:gank_flutter/ui/page/splash_page.dart';
import 'package:redux/redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GankLocalizationDelegate.delegate
          ],
          locale: store.state.locale,
          supportedLocales: [store.state.locale],
          routes: {
            ///注意只需要包裹第一次打开的页面，BuildContext 会传递给子widget树.
            SplashPage.ROUTE_NAME: (context) =>
                GankLocalizationsWrapper(child: SplashPage()),
            HomePage.ROUTE_NAME: (context) => HomePage(),
          },
        );
      }),
    );
  }
}
