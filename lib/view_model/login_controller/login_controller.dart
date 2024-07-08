import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';
import '../splash_services/session_manager.dart';

class LoginController extends ChangeNotifier{
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  void login(BuildContext context, String email, String password) async{
    setLoading(true);
    try{
      auth.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value){
        setLoading(false);
        Utils.toastMessage("Login Successful");
        SessionController().userId = value.user!.uid.toString();
        Navigator.pushNamedAndRemoveUntil(context, RouteName.dashboardScreen, (route) => false);
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
      });
    }catch(msg){
      setLoading(false);
      Utils.toastMessage(msg.toString());
    }
  }
}