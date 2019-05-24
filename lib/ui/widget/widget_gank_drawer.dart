import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gank_flutter/redux/app_state.dart';
import 'package:gank_flutter/ui/page/login_page.dart';
import 'package:gank_flutter/ui/page/setting_page.dart';
import 'package:gank_flutter/ui/widget/widget_cion_font.dart';
import 'package:gank_flutter/ui/widget/widget_sizable_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gank_flutter/utils/commonUtils.dart';

/// 自定义Drawer
class GankDrawer extends StatefulWidget {
  @override
  _GankDrawerState createState() => _GankDrawerState();
}

class _GankDrawerState extends State<GankDrawer> with TickerProviderStateMixin {
  Animation<Offset> _drawerDetailsPosition;
  bool _showDrawerContents = true;
  AnimationController _controllerDrawer;
  Animation<double> _drawerContentOpacity;

  Animatable<Offset> _drawerDetailsTween;

  @override
  void initState() {
    super.initState();

    ///初始化动画相关
    _controllerDrawer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _drawerContentOpacity = CurvedAnimation(
        parent: ReverseAnimation(_controllerDrawer),
        curve: Curves.fastOutSlowIn);

    _drawerDetailsTween = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).chain(CurveTween(
      curve: Curves.fastOutSlowIn,
    ));
    _drawerDetailsPosition = _controllerDrawer.drive(_drawerDetailsTween);
  }

  @override
  Widget build(BuildContext context) {
    return SizableDrawer(
      widthPercent: 0.75,
      child: Column(
        children: <Widget>[
          StoreBuilder<AppState>(
            builder: (context, store) => UserAccountsDrawerHeader(
                  accountName: Text(store.state.userInfo?.userName ??
                      CommonUtils.getLocale(context).pleaseLogin),
                  accountEmail: Text(
                      store.state.userInfo?.userDesc ?? '~~(>_<)~~ 什么也没有~'),
                  currentAccountPicture: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(LoginPage.ROUTER_NAME);
                    },
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1.0, color: Colors.white)),
                      child: ClipOval(
                        child: Image.asset('images/gank.png'),
                      ),
                      margin: EdgeInsets.zero,
                    ),
                  ),
//              onDetailsPressed: ,
                ),
          ),
          MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Expanded(
                  child: ListView(
                children: <Widget>[
                  FadeTransition(
                    opacity: _drawerContentOpacity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: ListTile(
                            leading: Icon(
                              IconFont(0xe655),
                              color: Color(0xff737373),
                            ),
                            title: Text(
                              CommonUtils.getLocale(context).searchGanHuo,
                            ),
                            onTap: () {},
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            IconFont(0xe8a6),
                            color: Color(0xff737373),
                          ),
                          title: Text(
                            CommonUtils.getLocale(context).searchGanHuo,
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(
                            IconFont(0xe62c),
                            color: Color(0xff737373),
                          ),
                          title: Text(
                            CommonUtils.getLocale(context).searchGanHuo,
                          ),
                          onTap: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            height: 0,
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            IconFont(0xe621),
                            color: Color(0xff737373),
                          ),
                          title: Text(
                            CommonUtils.getLocale(context).setting,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return SettingPage();
                            }));
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            IconFont(0xe710),
                            color: Color(0xff737373),
                          ),
                          title: Text(
                            CommonUtils.getLocale(context).about,
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(
                            IconFont(0xe6ab),
                            color: Color(0xff737373),
                          ),
                          title: Text(
                            CommonUtils.getLocale(context).starGank,
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(
                            IconFont(0xe61a),
                            color: Color(0xff737373),
                          ),
                          title: Text(
                            CommonUtils.getLocale(context).feedbackShort,
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  )
                ],
              )))
        ],
      ),
    );
  }
}
