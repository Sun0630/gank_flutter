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
  String get pleaseLogin => '请先登录';

  @override
  String get noDesc => '此人很懒，什么都没写~';

  @override
  String get searchGanHuo => '搜索干货';

  @override
  String get historyGanHuo => '历史干货';

  @override
  String get submitGankHuo => '提交干货';

  @override
  String get setting => '设置';

  @override
  String get about => '关于';

  @override
  String get starGank => '点赞';

  @override
  String get feedbackShort => '反馈';

  @override
  String get themeSetting => '主题设置';

  @override
  String get languageSetting => '语言设置';

  @override
  List<String> themeColorList = [
    '默认色',
    '海棠红',
    '鸢尾蓝',
    '孔雀绿',
    '柠檬黄',
    '藤萝紫',
    '暮云灰',
    '虾壳青',
    '牡丹粉',
    '筍皮棕',
  ];


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
