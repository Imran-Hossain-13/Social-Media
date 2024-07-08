import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';
import '../splash_services/session_manager.dart';

class ForgotPasswordController extends ChangeNotifier{
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  void forgotPassword(BuildContext context, String email) async{
    setLoading(true);
    try{
      auth.sendPasswordResetEmail(email: email).then((value){
        setLoading(false);
        Utils.toastMessage("Check your email for password recovery request");
      }).onError((error, stackTrace){
        setLoading(false);
        Utils.toastMessage(error.toString());
      });
    }catch(msg){
      setLoading(false);
      Utils.toastMessage(msg.toString());
    }
  }
}