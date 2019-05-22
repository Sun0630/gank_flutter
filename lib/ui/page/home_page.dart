import 'package:flutter/material.dart';
import 'package:gank_flutter/api/api_gank.dart';
import 'package:gank_flutter/common/event/event_change_welfare.dart';
import 'package:gank_flutter/common/event/event_refresh_new.dart';
import 'package:gank_flutter/common/event/event_show_history_date.dart';
import 'package:gank_flutter/common/manager/app_manager.dart';
import 'package:gank_flutter/ui/page/category_page.dart';
import 'package:gank_flutter/ui/page/favorite_page.dart';
import 'package:gank_flutter/ui/page/new_page.dart';
import 'package:gank_flutter/ui/page/welfare_page.dart';
import 'package:gank_flutter/ui/widget/widget_bottom_tab.dart';
import 'package:gank_flutter/ui/widget/widget_cion_font.dart';
import 'package:gank_flutter/ui/widget/widget_gank_drawer.dart';
import 'package:gank_flutter/ui/widget/widget_history_date.dart';
import 'package:gank_flutter/utils/commonUtils.dart';

class HomePage extends StatefulWidget {
  static const String ROUTE_NAME = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  List _historyData;
  String _currentDate = '';
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _getHistoryDate();
    _registerEventListener();
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
        ),
        HistoryDate(_historyData)
      ],
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Offstage(
        offstage: false,
        child: Text(_currentDate ?? ''),
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
        onPressed: () {
          if(_currentPageIndex == 0){
            // 弹出日期选择
            AppManager.notifyShowHistoryDate();
          }else if(_currentPageIndex == 1){
            // 去搜索页
          }else if(_currentPageIndex == 2){
            // 切换妹纸
            AppManager.eventBus.fire(ChangeWelfareCountEvent());
          }else{

          }

        });
  }

  IconData getActionsIcon() {
    if(_currentPageIndex == 0){
      return IconFont(0xe8a6);
    }else if(_currentPageIndex == 1){
      return IconFont(0xe783);
    }else if(_currentPageIndex == 2){
      return IconFont(0xe63a);
    }else{
      return IconFont(0xe619);
    }
  }

  void _pageChanged(int index) {
    if(index != 0){
      AppManager.eventBus.fire(ShowHistoryDateEvent.hide());
    }
    setState(() {
      if(_currentPageIndex != index){
        _currentPageIndex = index;
      }
    });
  }

  Future _getHistoryDate() async {
    var historyData = await GankApi.getHistoryDateData();
    setState(() {
      _historyData = historyData;
      _currentDate = CommonUtils.getLocale(context).homeTitle;
    });
  }

  /// 注册事件监听器
  void _registerEventListener() {
    AppManager.eventBus.on<RefreshNewEvent>().listen((event) {
      if (mounted) {
        setState(() {
          _currentDate = event.date;
        });
      }
    });
  }
}
