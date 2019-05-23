import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gank_flutter/common/constant/colors.dart';
import 'package:gank_flutter/common/localization/gank_localizations.dart';
import 'package:gank_flutter/redux/app_state.dart';

class LoginPage extends StatefulWidget {
  static const String ROUTER_NAME = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  final FocusNode mFocusEmailLogin = FocusNode();
  final FocusNode mFocusPwdLogin = FocusNode();

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, ThemeData>(
          builder: (context, vm) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [vm.primaryColor, AppColors.COLOR_GRADIENT_END],
                      tileMode: TileMode.mirror,
                      stops: [0.0, 1.0],
                      end: FractionalOffset(0.0, 0.0),
                      begin: FractionalOffset(1.0, 1.0))),
              child: Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[_buildSignIn(context, vm)],
                  ),
                  SafeArea(
                      child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: IconButton(
                        icon: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        GankLocalizations.of(context).currentLocalized.loginTip,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'WorkSansMedium'),
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: !isLoading,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                ],
              ),
            );
          },
          converter: (store) => store.state.themeData),
    );
  }

  /// 构建登录
  Widget _buildSignIn(BuildContext context, ThemeData themeData) {
    return Container(
      padding: EdgeInsets.only(top: 150),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Container(
                  width: 300.0,
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20, right: 25.0, left: 25.0),
                        child: TextField(
                          focusNode: mFocusEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          onChanged: (value) {},
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                IconData(0xe653, fontFamily: 'IconFont'),
                                color: Colors.black,
                                size: 22.0,
                              ),
                              hintStyle: TextStyle(
                                  fontFamily: 'WorkSansSemiBold',
                                  fontSize: 17.0),
                              hintText: GankLocalizations.of(context)
                                  .currentLocalized
                                  .userNameHint),
                        ),
                      ),
                      Container(
                        height: 1.0,
                        width: 250.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, left: 25, right: 25),
                        child: TextField(
                          focusNode: mFocusPwdLogin,
                          controller: loginPwdController,
                          obscureText: true,
                          style: TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          onChanged: (value) {},
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                IconData(0xe659, fontFamily: 'IconFont'),
                                color: Colors.black,
                                size: 22.0,
                              ),
                              hintStyle: TextStyle(
                                  fontFamily: 'WorkSansSemiBold',
                                  fontSize: 17.0),
                              hintText: GankLocalizations.of(context)
                                  .currentLocalized
                                  .passwordHint),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
//                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 170),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: themeData.primaryColor,
                        blurRadius: 20.0,
                        offset: Offset(1.0, 6.0)),
                    BoxShadow(
                        color: AppColors.COLOR_GRADIENT_END,
                        blurRadius: 20.0,
                        offset: Offset(1.0, 6.0))
                  ],
                  gradient: LinearGradient(
                      colors: [
                        AppColors.COLOR_GRADIENT_END,
                        themeData.primaryColor
                      ],
                      tileMode: TileMode.clamp,
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0]),
                ),
                child: _buildLoginButton(),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.white10, Colors.white],
                        begin: const FractionalOffset(0, 0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  width: 100.0,
                  height: 1,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    'Or',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'WorkSansMedium'),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.white10, Colors.white],
                        begin: const FractionalOffset(1.0, 1.0),
                        end: const FractionalOffset(0, 0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  width: 100.0,
                  height: 1,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                // 需要调用原生
                Fluttertoast.showToast(
                    msg: 'Github login...', gravity: ToastGravity.CENTER);
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Icon(
                  IconData(0xe612, fontFamily: 'IconFont'),
                  size: 30,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 登录按钮
  Widget _buildLoginButton() {
    return MaterialButton(
        highlightColor: Colors.transparent,
        splashColor: AppColors.COLOR_GRADIENT_END,
        onPressed: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
          child: Text(
            'LOGIN',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontFamily: 'WorkSansBold'),
          ),
        ));
  }
}
