import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../res/color.dart';

class Utils{
  static void fieldFocus(BuildContext context, FocusNode currentFocus, FocusNode nextFocus ){
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message){
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.primaryTextTextColor,
      textColor: AppColors.whiteColor,
    );
  }
}