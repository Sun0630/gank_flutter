import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gank_flutter/api/api_gank.dart';
import 'package:gank_flutter/model/gank_item_entity.dart';
import 'package:gank_flutter/ui/widget/indicator_factory.dart';
import 'package:gank_flutter/ui/widget/widget_list_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GankListCategory extends StatefulWidget {
  final String category;

  GankListCategory(this.category);

  @override
  _GankListCategoryState createState() => _GankListCategoryState();
}

class _GankListCategoryState extends State<GankListCategory>
    with AutomaticKeepAliveClientMixin {
  bool _isLoading = true;
  int _page = 1;
  List _gankItems = [];
  RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
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
            child: SmartRefresher(
              controller: _refreshController,
              header: buildDefaultHeader(context, 0),
              footer: buildDefaultFooter(context, 0),
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              enablePullUp: true,
              child: ListView.builder(
                itemCount: _gankItems?.length ?? 0,
                itemBuilder: (context, index) =>
                    GankListItem(_gankItems[index]),
              ),
            ),
          ),
          Offstage(
            offstage: !_isLoading,
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          )
        ],
      ),
    );
  }

  /// 获取分类数据
  void _getCategoryData({bool loadMore = false}) async {
    var categoryData = await GankApi.getCategoryData(
        widget.category == '全部' ? 'all' : widget.category, _page);

    var gankItems = categoryData['results'].map<GankItemEntity>((itemJson) {
      return GankItemEntity.fromJson(itemJson, category: widget.category);
    }).toList();

    if (loadMore) {
      _refreshController.loadComplete();
      setState(() {
        _gankItems.addAll(gankItems);
        _isLoading = false;
      });
    } else {
      _refreshController.refreshCompleted();
      setState(() {
        _gankItems = gankItems;
        _isLoading = false;
      });
    }
  }

  /// 下拉刷新
  _onRefresh() {
    _page = 1;
    _getCategoryData();
  }

  /// 上拉
  _onLoading() {
    _page++;
    _getCategoryData(loadMore: true);
  }

  @override
  bool get wantKeepAlive => true;
}
