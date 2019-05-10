import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
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
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.gankItemEntity.url,
      withLocalStorage: true,
      withJavascript: true,
      initialChild: Container(
        color: Colors.redAccent,
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
              onPressed: () {
                setState(() {
                  _favorite = !_favorite;
                });
              }),
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
