import 'package:flutter/material.dart';
import 'package:gank_flutter/common/event/event_refresh_new.dart';
import 'package:gank_flutter/common/event/event_show_history_date.dart';
import 'package:gank_flutter/common/manager/app_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gank_flutter/utils/commonUtils.dart';
import 'package:gank_flutter/utils/time_utils.dart';

class HistoryDate extends StatefulWidget {
  List _historyDate;

  HistoryDate(this._historyDate);

  @override
  _HistoryDateState createState() => _HistoryDateState();
}

class _HistoryDateState extends State<HistoryDate>
    with TickerProviderStateMixin {
  Animation<Offset> _historyDateDetailPosition;
  AnimationController _controllerHistoryDate;
  Animation<double> _historyDateContentsOpacity;
  Animatable<Offset> _historyDateDetailsTween;

  String _currentDate;

  /// 是否显示日期
  bool _showHistoryDate = false;

  @override
  void initState() {
    super.initState();
    // 初始化动画相关
    _controllerHistoryDate =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _historyDateContentsOpacity = CurvedAnimation(
        parent: ReverseAnimation(_controllerHistoryDate),
        curve: Curves.fastOutSlowIn);

    _historyDateDetailsTween =
        Tween<Offset>(begin: const Offset(0.0, -0.1), end: Offset.zero)
            .chain(CurveTween(curve: Curves.fastOutSlowIn));

    _historyDateDetailPosition =
        _controllerHistoryDate.drive(_historyDateDetailsTween);

    // 接收藏page_home发送的event
    AppManager.eventBus.on<ShowHistoryDateEvent>().listen((event) {
      if (mounted) {
        // 挂载成功，视图树渲染完毕
        if (event.forceHide) {
          _showHistoryDate = false;
        } else {
          _showHistoryDate = !_showHistoryDate;
        }

        if (_showHistoryDate) {
          _controllerHistoryDate.forward();
        } else {
          _controllerHistoryDate.reverse();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _historyDateDetailPosition,
      child: FadeTransition(
        opacity: ReverseAnimation(_historyDateContentsOpacity),
        child: Card(
          elevation: 5.0,
          margin: EdgeInsets.all(0),
          child: Container(
            color: Colors.white,
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  widget._historyDate == null ? 0 : widget._historyDate.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
//                    CommonUtils.showToast(widget._historyDate[0]);
                    setState(() {
                      _currentDate = widget._historyDate[index];
                    });
                    // 通知首页更新
                    AppManager.eventBus.fire(RefreshNewEvent(_currentDate));
                  },
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                getDay(widget._historyDate[index]),
                                style: Theme.of(context)
                                    .textTheme
                                    .body2
                                    .copyWith(
                                        fontSize: 18,
                                        color: (widget._historyDate[index] ==
                                                _currentDate)
                                            ? Theme.of(context).primaryColor
                                            : Colors.black),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 3.0, bottom: 2.0),
                                child: Text(
                                  getWeekDay(widget._historyDate[index]),
                                  style: Theme.of(context)
                                      .textTheme
                                      .body2
                                      .copyWith(
                                          fontSize: 8,
                                          color: (widget._historyDate[index] ==
                                                  _currentDate)
                                              ? Theme.of(context).primaryColor
                                              : Colors.black),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 3.0, bottom: 2.0),
                            child: Text(
                              getMonth(widget._historyDate[index]),
                              style: Theme.of(context).textTheme.body2.copyWith(
                                  fontSize: 8,
                                  color: (widget._historyDate[index] ==
                                          _currentDate)
                                      ? Theme.of(context).primaryColor
                                      : Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
