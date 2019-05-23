import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gank_flutter/common/event/event_refresh_db.dart';
import 'package:gank_flutter/common/localization/gank_localizations.dart';
import 'package:gank_flutter/common/manager/app_manager.dart';
import 'package:gank_flutter/common/manager/favorite_manager.dart';
import 'package:gank_flutter/model/gank_item_entity.dart';
import 'package:gank_flutter/redux/app_state.dart';
import 'package:gank_flutter/ui/widget/indicator_factory.dart';
import 'package:gank_flutter/ui/widget/widget_list_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redux/redux.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with AutomaticKeepAliveClientMixin {
  bool _isLoading = true;
  bool _isEmpty = false;
  List _gankItems = [];

  RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    AppManager.eventBus.on<RefreshDbEvent>().listen((event) {
      if (mounted) {
        print('receive...favorite');
        _refreshFavorites();
      }
    });

    _readFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Offstage(
            offstage: _isLoading || _isEmpty,
            child: SmartRefresher(
              controller: _refreshController,
              enablePullUp: false,
              header: buildDefaultHeader(context, 0),
              onRefresh: _refresh,
              child: ListView.builder(
                  itemCount: _gankItems?.length ?? 0,
                  itemBuilder: (context, index) =>
                      GankListItem(_gankItems[index])),
            ),
          ),
          Offstage(
              offstage: !_isLoading,
//              offstage: true,
              child: Center(
                child: CircularProgressIndicator(),
              )),
          Offstage(
            offstage: !_isEmpty,
//            offstage: false,
            child: StoreConnector<AppState, ThemeData>(
              converter: (store) => store.state.themeData,
              builder: (BuildContext context, ThemeData themeData) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'images/favorite_empty.png',
                        width: 130,
                        color: themeData.primaryColor,
                      ),
                      Text(
                        GankLocalizations.of(context)
                            .currentLocalized
                            .noFavorite,
                        style: Theme.of(context).textTheme.body2.copyWith(
                            color: themeData.primaryColor,
                            fontFamily: 'WorkSansMedium'),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _readFavorites() async {
    List<GankItemEntity> gankItems = await _getFavoritesData();
    setState(() {
      _isLoading = false;
      _gankItems = gankItems;
      _isEmpty = gankItems.length == 0;
    });
  }

  /// 从数据库中查询收藏信息
  Future<List<GankItemEntity>> _getFavoritesData() async {
    var results = await FavoriteManager.find({});
    print('something find...$results');
    return results
            ?.map<GankItemEntity>(
                (itemJson) => GankItemEntity.fromJson(itemJson))
            ?.toList() ??
        [];
  }

  void _refresh() {
    _refreshFavorites();
  }

  void _refreshFavorites() async {
    List<GankItemEntity> gankItems = await _getFavoritesData();
    print('gank:${gankItems.length}');
    setState(() {
      _gankItems = gankItems;
      _isEmpty = gankItems.length == 0;
      _refreshController.refreshCompleted();
    });
  }
}
