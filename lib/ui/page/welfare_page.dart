import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gank_flutter/api/api_gank.dart';
import 'package:gank_flutter/common/event/event_change_welfare.dart';
import 'package:gank_flutter/common/manager/app_manager.dart';
import 'package:gank_flutter/model/gank_item_entity.dart';
import 'package:gank_flutter/ui/widget/indicator_factory.dart';
import 'package:gank_flutter/utils/commonUtils.dart';
import 'package:gank_flutter/utils/time_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WelfarePage extends StatefulWidget {
  @override
  _WelfarePageState createState() => _WelfarePageState();
}

class _WelfarePageState extends State<WelfarePage> with AutomaticKeepAliveClientMixin{
  bool _isLoading = true;
  bool _isOneColumn = true;
  int _page = 1;
  List _gankItems = [];
  RefreshController _refresherController;

  @override
  void initState() {
    super.initState();
    AppManager.eventBus.on<ChangeWelfareCountEvent>().listen((event) {
      if (mounted) {
        setState(() {
          _isOneColumn = !_isOneColumn;
        });
      }
    });
    _refresherController = RefreshController();
    _getCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Offstage(
            offstage: _isLoading,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SmartRefresher(
                enablePullUp: true,
                onRefresh: _onRefresh,
                onLoading: onLoadMore,
                controller: _refresherController,
                footer: buildDefaultFooter(context, 0),
                header: buildDefaultHeader(context, 0),

//                child: GridView.builder(
//                  itemCount: _gankItems.length,
//                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                        crossAxisCount: 1,
//                        childAspectRatio: 1.0,
//                        mainAxisSpacing: 10.0,
//                        crossAxisSpacing: 10.0),
//                    itemBuilder: (context, index) {
//                      return _buildImageWidget(_gankItems[0]);
//                    }),
                child: GridView.count(
                  crossAxisCount: _isOneColumn ? 1 : 2,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  children: <Widget>[
                    _buildImageWidget(_gankItems[0]),
                    _buildImageWidget(_gankItems[1]),
                    _buildImageWidget(_gankItems[2]),
                    _buildImageWidget(_gankItems[3]),
                    _buildImageWidget(_gankItems[4]),
                    _buildImageWidget(_gankItems[5]),
                    _buildImageWidget(_gankItems[6]),
                  ],
                ),
              ),
            ),
          ),
          Offstage(
            offstage: !_isLoading,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }

  void _getCategoryData({bool loadMore = false}) async {
    var categoryData = await GankApi.getCategoryData('福利', _page);
    var gankItems = categoryData['results'].map<GankItemEntity>((itemJson) {
      return GankItemEntity.fromJson(itemJson,
          category: CommonUtils.getLocale(context).gankWelfare);
    }).toList();

    if (loadMore) {
      _refresherController.loadComplete();
      setState(() {
        _gankItems.addAll(gankItems);
        _isLoading = false;
      });
    } else {
      _refresherController.refreshCompleted();
      setState(() {
        _gankItems = gankItems;
        _isLoading = false;
      });
    }
  }

  /// 下拉刷新
  void _onRefresh() {
    _page = 1;
    _getCategoryData();
  }

  /// 上拉加载
  void onLoadMore() {
    print('length:${_gankItems.length}');
    if (_gankItems.length <= 20) {
      _refresherController.loadNoData();
      return;
    }
    _page++;
    _getCategoryData(loadMore: true);
  }

  Widget _buildImageWidget(gankItem) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
              child: _isOneColumn
                  ? CachedNetworkImage(
                      imageUrl: gankItem.url,
                      placeholder: (context, url) {
                        return Center(
                          child: Container(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) => Icon(Icons.terrain),
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: gankItem.url,
                      placeholder: (context, url) {
                        return Center(
                          child: Container(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) => Icon(Icons.terrain),
                      fit: BoxFit.cover,
                    )),
          Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                color: Colors.black26,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      formatDateStr(gankItem.publishedAt),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
