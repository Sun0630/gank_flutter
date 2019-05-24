import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gank_flutter/common/constant/colors.dart';
import 'package:gank_flutter/common/constant/locale/locale_base.dart';
import 'package:gank_flutter/common/localization/gank_localizations.dart';
import 'package:gank_flutter/common/manager/app_manager.dart';
import 'package:gank_flutter/ui/widget/widget_expand_button.dart';

class CommonUtils {
  static StringBase getLocale(BuildContext context) {
    return GankLocalizations.of(context).currentLocalized;
  }

  static List<Color> getThemeListColor() {
    return [
      AppColors.PRIMARY_DEFAULT_COLOR, //默认色
      AppColors.PRIMARY_HTH_COLOR, //海棠红
      AppColors.PRIMARY_YWL_COLOR, //鸢尾蓝
      AppColors.PRIMARY_KQL_COLOR, //孔雀绿
      AppColors.PRIMARY_NMH_COLOR, //柠檬黄
      AppColors.PRIMARY_TLZ_COLOR, //藤萝紫
      AppColors.PRIMARY_MYH_COLOR, //暮云灰
      AppColors.PRIMARY_XKQ_COLOR, //虾壳青
      AppColors.PRIMARY_MDF_COLOR, //牡丹粉
      AppColors.PRIMARY_XPZ_COLOR, //筍皮棕
    ];
  }

  static showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: Colors.black,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white);
  }

  /// 选择主题颜色
  static showThemeDialog(BuildContext context) {
    CommonUtils.showCommitOptionDialog(
        context, CommonUtils.getLocale(context).themeColorList, (index) {
          // 切换主题
          AppManager.switchThemeData(context, index);
    },
        colorList: CommonUtils.getThemeListColor());
  }

  static showCommitOptionDialog(
      BuildContext context, List<String> commitMaps, ValueChanged<int> onTap,
      {width: 250.0, height: 480.0, List<Color> colorList}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              width: width,
              height: height,
              margin: EdgeInsets.all(6.0),
              padding: EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
              child: ListView.builder(
                  itemCount: commitMaps.length,
                  itemBuilder: (context, index) {
                    return ExpandButton(
                      maxLines: 2,
                      mainAxisAlignment: MainAxisAlignment.start,
                      fontSize: 14.0,
                      textColor: Colors.white,
                      text: commitMaps[index],
                      color: colorList != null
                          ? colorList[index]
                          : Theme.of(context).primaryColor,
                      onPress: (){
                        Navigator.of(context).pop();
                        onTap(index);
                      },
                    );
                  }),
            ),
          );
        });
  }
}
