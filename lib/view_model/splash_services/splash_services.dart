import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/view_model/splash_services/session_manager.dart';

import '../../utils/routes/route_name.dart';

class SplashServices{
  void isLogin(BuildContext context){
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user != null){
      SessionController().userId = user.uid.toString();
      Timer(const Duration(milliseconds: 3700), ()=> Navigator.pushNamedAndRemoveUntil(context, RouteName.dashboardScreen, (route) => false));
    }else{
      Timer(const Duration(milliseconds: 3700), ()=> Navigator.pushNamedAndRemoveUntil(context, RouteName.loginView, (route) => false));
    }
  }
}