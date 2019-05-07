import 'package:flutter/material.dart';
import 'package:gank_flutter/common/manager/app_manager.dart';
import 'package:gank_flutter/ui/page/category_page.dart';
import 'package:gank_flutter/ui/page/favorite_page.dart';
import 'package:gank_flutter/ui/page/new_page.dart';
import 'package:gank_flutter/ui/page/welfare_page.dart';
import 'package:gank_flutter/ui/widget/widget_bottom_tab.dart';
import 'package:gank_flutter/ui/widget/widget_cion_font.dart';
import 'package:gank_flutter/ui/widget/widget_gank_drawer.dart';
import 'package:gank_flutter/utils/commonUtils.dart';

class HomePage extends StatefulWidget {
  static const String ROUTE_NAME = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GankDrawer(),
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: BottomTabs(_pageController, _pageChanged),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: _pageChanged,
          children: <Widget>[
            NewPage(),
            CategoryPage(),
            WelfarePage(),
            FavoritePage()
          ],
        )
      ],
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
        onPressed: () {});
  }

  IconData getActionsIcon() {
    return IconFont(0xe8a6);
  }

  void _pageChanged(int index) {
    setState(() {});
  }
}
