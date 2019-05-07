import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gank_flutter/common/localization/gank_localizations.dart';

class GankLocalizationDelegate
    extends LocalizationsDelegate<GankLocalizations> {
  @override
  bool isSupported(Locale locale) {
    // 支持中英文
    return ['zh', 'en'].contains(locale.languageCode);
  }

  ///根据locale，创建一个对象用于提供当前locale下的文本显示
  @override
  Future<GankLocalizations> load(Locale locale) {
    return SynchronousFuture<GankLocalizations>(GankLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<GankLocalizations> old) {
    return false;
  }

  /// 全局静态代理
  static GankLocalizationDelegate delegate = GankLocalizationDelegate();
}
