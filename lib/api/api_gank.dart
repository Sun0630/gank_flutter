import 'package:gank_flutter/common/net/http_manager.dart';
import 'package:gank_flutter/common/net/http_response.dart';

class GankApi {
  static const String API_GANK_HOST = 'http://gank.io';

  //获取指定一天的数据
  static const String API_SPECIAL_DAY = "$API_GANK_HOST/api/day/";
  // 获取最新数据
  static const String API_TODAY = "$API_GANK_HOST/api/today";
  /// 获取日期数据
  static const String API_HISTORY = "$API_GANK_HOST/api/day/history";

  /// 获取最新一天的数据
  static getTodayData() async {
    HttpResponse httpResponse =  await HttpManager.fetch(API_TODAY);
    return httpResponse.data;
  }


  ///获取所有的历史干货日期.
  static getHistoryDateData() async {
    HttpResponse response = await HttpManager.fetch(API_HISTORY);
    return response.data['results'];
  }


  /// 获取指定日期的数据
  static getSpecialDayData(String date) async{
    HttpResponse response = await HttpManager.fetch(API_SPECIAL_DAY+date.replaceAll('-', '/'));
    return response.data;
  }


}
