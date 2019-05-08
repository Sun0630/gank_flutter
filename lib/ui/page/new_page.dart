import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gank_flutter/api/api_gank.dart';
import 'package:gank_flutter/model/gank_item_entity.dart';
import 'package:gank_flutter/model/gank_post.dart';
import 'package:gank_flutter/ui/page/gallery_page.dart';
import 'package:gank_flutter/ui/widget/indicator_factory.dart';
import 'package:gank_flutter/ui/widget/widget_list_item.dart';
import 'package:gank_flutter/ui/widget/widget_list_title.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  bool _isLoadig = true;
  String _date;
  String _girlImage;
  List<GankItemEntity> _gankItems;
  RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();

    getNewData();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Offstage(
          // true：不显示
          offstage: _isLoadig ? true : false,
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: _onRefresh,
            controller: _refreshController,
            header: buildDefaultHeader(context, 0),
//            header: ClassicHeader(),
            child: _buildListView(),
          ),
        ),
        Offstage(
          offstage: _isLoadig ? false : true,
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        )
      ],
    );
  }

  ListView _buildListView() {
    return ListView.builder(
        itemCount: _gankItems == null ? 0 : _gankItems.length + 1,
        itemBuilder: (context, position) {
          if (position == 0) {
            // 构造一个banner
            return _buildImageBanner(context);
          } else {
            GankItemEntity gankItemEntity = _gankItems[position - 1];
            return gankItemEntity.isTitle
                ? GankItemTitle(gankItemEntity.category)
                : GankListItem(gankItemEntity);
          }
        });
  }

  /// 获取首页数据
  Future getNewData({String date, bool isRefresh}) async {
//    if (!isRefresh) {
//      setState(() {
//        _isLoadig = true;
//      });
//    }

    var todayJson = await GankApi.getTodayData();

    var todayItem = GankPost.fromJson(todayJson);

    setState(() {
      _gankItems = todayItem.gankItems;
      _girlImage = todayItem.girlImage;
      print('imageUrl:${_girlImage}');
      _isLoadig = false;
    });
  }

  /// 广告头
  GestureDetector _buildImageBanner(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return GalleryPage([_girlImage], '');
          }));
        },
        child: CachedNetworkImage(
          imageUrl: _girlImage,
          height: 200,
          fit: BoxFit.cover,
        ));
  }

  Future _onRefresh() async {
    await getNewData(isRefresh: true);
    _refreshController.refreshCompleted();
  }
}
