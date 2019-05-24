import 'package:flutter/material.dart';
import 'package:gank_flutter/model/gank_item_entity.dart';
import 'package:gank_flutter/ui/page/gallery_page.dart';
import 'package:gank_flutter/ui/page/web_view_page.dart';
import 'package:gank_flutter/ui/widget/widget_cion_font.dart';
import 'package:gank_flutter/utils/time_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GankListItem extends StatefulWidget {
  final GankItemEntity gankItemEntity;

  GankListItem(this.gankItemEntity);

  @override
  _GankListItemState createState() => _GankListItemState();
}

class _GankListItemState extends State<GankListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return WebViewPage(widget.gankItemEntity);
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).dividerColor, width: 0.0)),
        ),
        // 调整child到固定高度，效率会有问题
        child: IntrinsicHeight(
          child: Row(
            // 纵轴拉伸
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildGankListItem(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildGankListItem(BuildContext context) {
    var contentWidgets = <Widget>[
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(16.0),
            child: Text(
              widget.gankItemEntity.desc,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.body1,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      widget.gankItemEntity.who.startsWith('lijinshan')
                          ? IconData(0xe846, fontFamily: 'IconFont')
                          : Icons.person_outline,
                      color: Theme.of(context).primaryColor,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: SizedBox(
                        width: 75.0,
                        child: Text(
                          widget.gankItemEntity.who,
                          style: Theme.of(context).textTheme.body2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        formatDateStr(widget.gankItemEntity.publishedAt),
                        style: Theme.of(context).textTheme.body2,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ))
    ];

    // 右侧缩略图
    if (widget.gankItemEntity.images != null &&
        widget.gankItemEntity.images.isNotEmpty) {
      var imageUrl = widget.gankItemEntity.images[0];
      contentWidgets.add(GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return GalleryPage(
                widget.gankItemEntity.images, widget.gankItemEntity.desc);
          }));
        },
        child: Container(
          width: 80.0,
          margin: EdgeInsets.only(right: 16, bottom: 20, top: 20),
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                      imageUrl.replaceAll('large', 'thumbnail')))),
        ),
      ));
    }

    return contentWidgets;
  }
}
