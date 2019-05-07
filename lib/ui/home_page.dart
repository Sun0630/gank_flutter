import 'package:flutter/material.dart';
import 'package:gank_flutter/common/manager/app_manager.dart';
import 'package:gank_flutter/utils/commonUtils.dart';
import 'package:gank_flutter/widget/widget_cion_font.dart';
import 'package:gank_flutter/widget/widget_gank_drawer.dart';
class HomePage extends StatefulWidget {
  static const String ROUTE_NAME = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GankDrawer(),
      appBar: _buildAppBar(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Offstage(
        offstage: false,
        child: Text(CommonUtils.getLocale(context).homeTitle),
      ),
      actions: <Widget>[_buildActions()],
    );
  }

  /// 构建右侧图标
  IconButton _buildActions() {
    return IconButton(
        icon: Icon(
          getActionsIcon(),
          size: 22,
          color: Colors.white,
        ),
        onPressed: (){
        });
  }

  IconData getActionsIcon() {
    return IconFont(0xe8a6);
  }
}
