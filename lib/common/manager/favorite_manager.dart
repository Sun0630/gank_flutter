import 'dart:io';

import 'package:gank_flutter/common/constant/string.dart';
import 'package:gank_flutter/model/gank_item_entity.dart';
import 'package:objectdb/objectdb.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FavoriteManager {
  static ObjectDB db;

  static init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path =
        join(documentDirectory.path, '${AppStrings.STRING_DB_FAVORITE}');
    db = ObjectDB(path);
    await db.open();
  }

  /// 插入一条数据
  static insert(GankItemEntity gankItem) async {
    var objectId = await db.insert(gankItem.toJson());
    print('insert success:$objectId');
  }

  /// 查找
  static find(Map<dynamic, dynamic> query) async {
    return await db.find(query);
  }

  /// 删除
  static remove(GankItemEntity gankItem) async {
    await db.remove({'itemId': gankItem.itemId});
  }
}
