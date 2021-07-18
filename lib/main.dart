import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/application.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
    statusBarIconBrightness: Brightness.light,
    // statusBarBrightness: Brightness.dark
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(Application());
  });
}
