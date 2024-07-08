import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/res/color.dart';
import '../../res/fonts.dart';
import '../../view_model/splash_services/splash_services.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    splashServices.isLogin(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset("assets/lottie/loader.json",),
              const Padding(
                padding:  EdgeInsets.symmetric(vertical: 20),
                child: Center(child: Text('Seed world' , style: TextStyle(fontFamily: AppFonts.sfProDisplayBold,color: AppColors.primaryColor, fontSize: 30, fontWeight: FontWeight.w700),)),
              ),
            ],
          )
      ),
    );
  }
}
