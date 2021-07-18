import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:task/util/colors/app_colors.dart';
import 'package:task/util/navigator/routes.dart';
import 'package:task/util/size_config/size_config.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final facebookLogin = FacebookLogin();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sign In',
              style:
                  TextStyle(color: AppColors.colorOffWhiteText, fontSize: 28),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            Text(
              'Sign in with your facebook account',
              style:
                  TextStyle(color: AppColors.colorOffWhiteText, fontSize: 16),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            FacebookSignInButton(onPressed: () {
              _fbLogin();
              // Keys.navKey.currentState.pushReplacementNamed(Routes.homeScreen);
            }),
          ],
        ),
      ),
    );
  }

  void _fbLogin() async {
    await facebookLogin.logOut();
    _logInFb();
  }

  Future<void> _logInFb() async {
    final result = await facebookLogin.logIn(['email']).catchError((e) {
      print('inside fb' + e.toString());
    });
    print(result.accessToken);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        Keys.navKey.currentState.pushReplacementNamed(Routes.homeScreen);
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
      default:
        break;
    }
  }
}
