import 'package:flutter/material.dart';
import 'package:gank_flutter/common/manager/app_manager.dart';
import 'package:gank_flutter/ui/page/home_page.dart';

class SplashPage extends StatefulWidget {
  static const String ROUTE_NAME = '/';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 生命周期函数,紧跟着initState调用
    AppManager.initApp(context).then((_) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, HomePage.ROUTE_NAME);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
        children: <Widget>[
          Align(
            alignment: FractionalOffset.center,
            child: Padding(
              padding: EdgeInsets.only(bottom: 150.0),
              child: Image.asset(
                'images/gank.png',
                width: 100,
              ),
            ),
          ),
          Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  '${DateTime.now().year}@gank.io',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontFamily: 'WorkSansMedium'),
                ),
              ))
        ],
      )),
    );
  }
}
