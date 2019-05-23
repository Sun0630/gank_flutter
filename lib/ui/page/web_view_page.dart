import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gank_flutter/common/event/event_refresh_db.dart';
import 'package:gank_flutter/common/manager/app_manager.dart';
import 'package:gank_flutter/common/manager/favorite_manager.dart';
import 'package:gank_flutter/model/gank_item_entity.dart';

class WebViewPage extends StatefulWidget {
  final GankItemEntity gankItemEntity;

  WebViewPage(this.gankItemEntity);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool _favorite = false;

  @override
  void initState() {
    super.initState();
    _readFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.gankItemEntity.url,
      withLocalStorage: true,
      withJavascript: true,
      initialChild: Container(
        child: const Center(
          child: Text('waiting...'),
        ),
      ),
      appBar: AppBar(
        title: Text(widget.gankItemEntity.desc),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.favorite,
                color: _favorite ? Colors.red : Colors.white,
              ),
              onPressed: () async {
                if (_favorite) {
                  await FavoriteManager.remove(widget.gankItemEntity);
                  setState(() {
                    _favorite = false;
                  });
                } else {
                  print('INSERT ONE');
                  await FavoriteManager.insert(widget.gankItemEntity);
                  setState(() {
                    _favorite = true;
                  });
                }
                AppManager.eventBus.fire(RefreshDbEvent());
              }),
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  /// 读取是否收藏
  void _readFavorites() async {
    var resluts =
        await FavoriteManager.find({'url': widget.gankItemEntity.url});
    print('result:$resluts');
    if (resluts.length > 0) {
      setState(() {
        _favorite = true;
      });
    }
  }
}
