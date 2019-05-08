import 'package:gank_flutter/model/gank_item_entity.dart';

/// 首页数据解析实体
class GankPost {
  List<String> category;
  Map itemDataMap = Map();
  String girlImage;

  List<GankItemEntity> gankItems = [];

  GankPost.fromJson(Map<String, dynamic> json)
      : category =
            json['category']?.map<String>((c) => c.toString())?.toList() {
    var results = json['results'];
    results.forEach((name, value) {
      if (name != '福利') {
        itemDataMap[name] = _createGankItemListFromJson(name, value);
      }
    });

    girlImage = json['results']['福利'][0]['url'];
  }

  List<GankItemEntity> _createGankItemListFromJson(name, value) {
    var gankItemList = value
        .map<GankItemEntity>(
            (item) => GankItemEntity.fromJson(item, category: name))
        .toList();

    gankItems.add(GankItemEntity.title(true, name));
    gankItems.addAll(gankItemList);
    return gankItemList;
  }
}
