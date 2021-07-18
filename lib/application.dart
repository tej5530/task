import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/ui/home_screen.dart';
import 'package:task/ui/login_screen.dart';
import 'package:task/ui/splash_screen.dart';
import 'package:task/util/colors/app_colors.dart';
import 'package:task/util/navigator/routes.dart';

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: AppColors.colorBackground,
      darkTheme: ThemeData(
        brightness: Brightness.light, //theme of app
        primaryColor: Colors.white,
      ),
      navigatorKey: Keys.navKey,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0,
            ),
            child: child);
      },
      routes: <String, WidgetBuilder>{
        Routes.loginScreen: (context) {
          //Sign In Page
          return LoginScreen();
        },
        Routes.homeScreen: (context) {
          //Sign In Page
          return HomeScreen();
        },
      },
    );
  }
}
