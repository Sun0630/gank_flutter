
import 'package:gank_flutter/common/constant/locale/locale_base.dart';

class StringEn extends StringBase{
  @override
  String get gankName => 'Gank';

  @override
  String get homeTitle => 'Today New Gank';

  @override
  String get gankWelfare => 'Welfare';

  @override
  // TODO: implement gankAllCategories
  List<String> get gankAllCategories => <String>[
    '全部',
    'Android',
    'iOS',
    'App',
    '前端',
    '瞎推荐',
    '拓展资源',
    '休息视频'
  ];
}