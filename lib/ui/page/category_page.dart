import 'package:flutter/material.dart';
import 'package:gank_flutter/common/constant/string.dart';
import 'package:gank_flutter/common/localization/gank_localizations.dart';
import 'package:gank_flutter/ui/widget/widget_list_category.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        initialIndex: 1,
        length: AppStrings.GANK_ALL_CATEGORY_KEYS.length,
        vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).dividerColor, width: 0.0))),
          child: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Theme.of(context).primaryColor,
              indicatorColor: Theme.of(context).primaryColor,
              controller: _tabController,
              tabs: GankLocalizations.of(context)
                  .currentLocalized
                  .gankAllCategories
                  .map<Widget>((page) {
                return Tab(
                  text: page,
                );
              }).toList()),
        ),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: AppStrings.GANK_ALL_CATEGORY_KEYS.map((category) {
            return GankListCategory(category);
          }).toList(),
        ))
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
