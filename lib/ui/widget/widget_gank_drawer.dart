import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gank_flutter/redux/app_state.dart';
import 'package:gank_flutter/ui/page/login_page.dart';
import 'package:gank_flutter/ui/widget/widget_sizable_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 自定义Drawer
class GankDrawer extends StatefulWidget {
  @override
  _GankDrawerState createState() => _GankDrawerState();
}

class _GankDrawerState extends State<GankDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizableDrawer(
      widthPercent: 0.75,
      child: Column(
        children: <Widget>[
          StoreBuilder<AppState>(
            builder: (context, state) => UserAccountsDrawerHeader(
                  accountName: Text('sunxin'),
                  accountEmail: Text('sunxin0630@gmail.com'),
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
                ),
          ),
          MediaQuery.removePadding(
              context: context,
              child: Expanded(
                  child: ListView(
                children: <Widget>[
                  Text('AAAAA'),
                  Text('bbbbb'),
                  Text('ccccc'),
                ],
              )))
        ],
      ),
    );
  }
}
