import 'package:gank_flutter/common/constant/locale/locale_base.dart';

class StringZh extends StringBase {
  @override
  String get gankName => '干货集中营';

  @override
  String get homeTitle => '今日最新干货';

  @override
  String get gankWelfare => '福利';

  @override
  String get noFavorite => '暂无收藏';

  @override
  String get userNameHint => '请输入用户名或邮箱';

  @override
  String get passwordHint => '请输入密码';

  @override
  String get loginTip => '请输入Github账号密码或者浏览器中授权登录';

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
