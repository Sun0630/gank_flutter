
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gank_flutter/common/constant/locale/locale_base.dart';
import 'package:gank_flutter/common/localization/gank_localizations.dart';

class CommonUtils{

  static StringBase getLocale(BuildContext context){
    return GankLocalizations.of(context).currentLocalized;
  }

  static showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: Colors.black,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white);
  }

}