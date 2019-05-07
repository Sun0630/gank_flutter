import 'package:flutter/material.dart';
import 'package:gank_flutter/ui/widget/widget_cion_font.dart';

class BottomTabs extends StatefulWidget {
  final PageController pageController;
  final ValueChanged<int> onTap;

  BottomTabs(this.pageController,this.onTap);

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int currentIndex = 0;

  var _bottomBars = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(IconFont(0xe67f)), title: Text('最新')),
    BottomNavigationBarItem(icon: Icon(IconFont(0xe603)), title: Text('分类')),
    BottomNavigationBarItem(icon: Icon(IconFont(0xe637)), title: Text('妹纸')),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), title: Text('收藏'))
  ];

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      items: _bottomBars,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      iconSize: 32,
      onTap: (int index){
        if(widget.onTap != null){
          currentIndex = index;
          widget.pageController.jumpToPage(index);
          widget.onTap(index);
        }
      },
    );
  }
}
