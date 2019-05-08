import 'package:gank_flutter/common/net/http_manager.dart';
import 'package:gank_flutter/common/net/http_response.dart';

class GankApi {
  static const String API_GANK_HOST = 'http://gank.io';

  static const String API_SPECIAL_DAY = "$API_GANK_HOST/api/day/";
  static const String API_TODAY = "$API_GANK_HOST/api/today";

  /// 获取最新一天的数据
  static getTodayData() async {
    HttpResponse httpResponse =  await HttpManager.fetch(API_TODAY);
    return httpResponse.data;
  }

  /// 获取指定日期的数据
  static getSpecialDayData() async {}
}
