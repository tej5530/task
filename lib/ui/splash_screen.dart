import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/util/colors/app_colors.dart';
import 'package:task/util/navigator/routes.dart';
import 'package:task/util/size_config/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/image/image.gif",
              height: SizeConfig.blockSizeVertical * 20,
              width: SizeConfig.blockSizeHorizontal * 35,
            ),
            Text(
              'Dog\'s Path',
              style: TextStyle(
                  color: AppColors.colorGrayText,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            Text('by',
                style: TextStyle(
                    color: AppColors.colorGrayText,
                    fontSize: 12,
                    fontWeight: FontWeight.normal)),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            Text(
              'VirtouStack Software Pvt.Ltd.',
              style: TextStyle(
                  color: AppColors.colorGrayText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  startTime() async {
    var _duration = Duration(seconds: 5); //splash timer = 2
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Keys.navKey.currentState.pushReplacementNamed(Routes.loginScreen);
  }
}
