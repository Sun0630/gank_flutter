import 'package:flutter/material.dart';
import 'package:gank_flutter/utils/commonUtils.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CommonUtils.getLocale(context).setting),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  CommonUtils.getLocale(context).themeSetting,
                  style: Theme.of(context).textTheme.body2,
                ),
                onTap: () {
                  CommonUtils.showThemeDialog(context);
                },
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  CommonUtils.getLocale(context).languageSetting,
                  style: Theme.of(context).textTheme.body2,
                ),
                onTap: () {},
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
