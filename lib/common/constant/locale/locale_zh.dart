import 'package:gank_flutter/common/constant/locale/locale_base.dart';

class StringZh extends StringBase {
  @override
  String get gankName => '干货集中营';

  @override
  String get homeTitle => '今日最新干货';

  @override
  List<String> get gankAllCategories => <String>[
    'All',
    'Android',
    'iOS',
    'App',
    'Web',
    'Recomend',
    'Extra',
    'Video'
  ];
}
