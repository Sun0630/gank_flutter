import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String ROUTE_NAME = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Offstage(
          offstage: false,
          child: Text('今日最新干货'),
        ),
      ),
    );
  }
}
