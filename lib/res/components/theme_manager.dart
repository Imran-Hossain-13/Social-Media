import 'package:flutter/material.dart';
import '../color.dart';
import '../fonts.dart';

ThemeData myTheme(){
  return ThemeData(
      primarySwatch: AppColors.primaryMaterialColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: AppColors.whiteColor,
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontSize: 22,fontFamily: AppFonts.sfProDisplayMedium,color: AppColors.primaryColor
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 40,color: AppColors.primaryTextTextColor,fontFamily: AppFonts.sfProDisplayMedium,fontWeight: FontWeight.w500,height: 1.6),
        displayMedium: TextStyle(fontSize: 32,color: AppColors.primaryTextTextColor,fontFamily: AppFonts.sfProDisplayMedium,fontWeight: FontWeight.w500,height: 1.6),
        displaySmall: TextStyle(fontSize: 28,color: AppColors.primaryTextTextColor,fontFamily: AppFonts.sfProDisplayMedium,fontWeight: FontWeight.w500,height: 1.9),
        headlineMedium: TextStyle(fontSize: 24,color: AppColors.primaryTextTextColor,fontFamily: AppFonts.sfProDisplayMedium,fontWeight: FontWeight.w500,height: 1.6),
        headlineSmall: TextStyle(fontSize: 20,color: AppColors.primaryTextTextColor,fontFamily: AppFonts.sfProDisplayMedium,fontWeight: FontWeight.w500,height: 1.6),
        titleSmall: TextStyle(fontSize: 17,color: AppColors.primaryTextTextColor,fontFamily: AppFonts.sfProDisplayBold,fontWeight: FontWeight.w700,height: 1.6),

        bodyLarge: TextStyle(fontSize: 17,color: AppColors.primaryTextTextColor,fontFamily: AppFonts.sfProDisplayBold,fontWeight: FontWeight.w700,height: 1.6),
        bodyMedium: TextStyle(fontSize: 17,color: AppColors.primaryTextTextColor,fontFamily: AppFonts.sfProDisplayRegular,height: 1.6),

        bodySmall: TextStyle(fontSize: 12,color: AppColors.primaryTextTextColor,fontFamily: AppFonts.sfProDisplayBold,height: 2.24),
      )
  );
}
