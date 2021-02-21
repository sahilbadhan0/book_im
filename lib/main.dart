import 'package:book_im/features/auth/ui/login_screen.dart';
import 'package:book_im/features/dashboard/dashboard.dart';
import 'package:book_im/features/home/HomeScreen.dart';
import 'package:book_im/utils/app_theme/appTheme.dart';
import 'package:flutter/material.dart';

import 'features/splash/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:AppTheme.appTheme,
      home: SplashScreen()
    );
  }
}

