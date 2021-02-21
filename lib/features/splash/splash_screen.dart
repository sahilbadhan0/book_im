import 'dart:convert';


import 'package:book_im/features/auth/bloc/auth_bloc.dart';
import 'package:book_im/features/auth/data/auth_repository.dart';
import 'package:book_im/features/auth/ui/login_screen.dart';
import 'package:book_im/features/dashboard/dashboard.dart';
import 'package:book_im/features/localDatabase/db_helper.dart';
import 'package:book_im/network/api_handler.dart';
import 'package:book_im/utils/AssetStrings.dart';
import 'package:book_im/utils/app_theme/app_colors.dart';
import 'package:book_im/utils/sharedPref/memory_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child:Text("BOOKiM",style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 20),)
          // Image.asset(AssetStrings.facebook)
      ),
    );
  }

  //Check if User is already logged in
  checkAuthentication() async {
    await MemoryManagement.init();
    await DatabaseHelper();
    // await Firebase.initializeApp();
    try {
      RestClient().create();
    } catch (e, st) {
      print("e $e, \n$st");
    }
    await Future.delayed(Duration(seconds: 2));
    String accessToken = MemoryManagement?.getAccessToken() ?? "";
    if (accessToken.isNotEmpty) {
      await loadUserData();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return Dashboard();
      }), (Route<dynamic> route) => false);
    } else {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return BlocProvider(
          create: (context) => AuthBloc(repository: AuthRepository()),
          child: LoginScreen(),
        );
      }), (Route<dynamic> route) => false);
    }
  }

  //Load User data from memory
  loadUserData(){
    /*String _data = MemoryManagement.getUserInfo()??"";
    String _detail = MemoryManagement.getUserDetail();

    LoggedInUser.setUser =  User.fromJson(jsonDecode(_data));

    if(_detail!=null){
      LoggedInUser.setUserDetail = UserDetail?.fromJson(jsonDecode(_detail??""));

    }*/

  }
}
