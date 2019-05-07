import 'package:flutter/material.dart';
import 'package:gank_flutter/common/constant/locale/locale_base.dart';
import 'package:gank_flutter/common/constant/locale/locale_en.dart';
import 'package:gank_flutter/common/constant/locale/locale_zh.dart';
/// 自定义多语言实现
class GankLocalizations{
  final Locale locale;

  GankLocalizations(this.locale);


  static Map<String,StringBase> _localizedValues = {
    'en':StringEn(),
    'zh':StringZh()
  };

  /// 获取当前本地语言
  StringBase get currentLocalized{
    return _localizedValues[locale.languageCode];
  }

  static GankLocalizations of(BuildContext context){
    return Localizations.of(context, GankLocalizations);
  }

}