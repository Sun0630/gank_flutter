
import 'package:gank_flutter/common/constant/locale/locale_base.dart';

class StringEn extends StringBase{
  @override
  String get gankName => 'Gank';

  @override
  String get homeTitle => 'Today New Gank';

  @override
  String get gankWelfare => 'Welfare';

  @override
  String get noFavorite => 'no Favorite';

  @override
  String get userNameHint => 'username or email';

  @override
  String get passwordHint => 'password';

  @override
  String get loginTip => 'Please enter your Github account password or authorized login in browser.';

  @override
  String get pleaseLogin => 'Please Login';

  @override
  String get noDesc => 'Nothing here';

  @override
  String get searchGanHuo => 'Search Gank';

  @override
  String get historyGanHuo => 'History gank';

  @override
  String get submitGankHuo => 'Submit gank';

  @override
  String get setting => 'Settings';

  @override
  String get about => 'About';

  @override
  String get feedbackShort => 'Feedback';

  @override
  String get starGank => 'Star Gank';

  @override
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