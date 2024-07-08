import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';
import '../splash_services/session_manager.dart';

class SignUpController extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("users");
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  void signup(BuildContext context,String userName, String email, String password) async{
    setLoading(true);
    try{
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) async {
        setLoading(false);
        Utils.toastMessage("Check your email and verify your account within 2 minutes");
        await auth.currentUser!.sendEmailVerification().then((value) async {
          Timer.periodic(const Duration(seconds: 3), (timer) {
            auth.currentUser!.reload();
            if(auth.currentUser!.emailVerified == true) {
              timer.cancel();
              Utils.toastMessage("Account create successfully");
              SessionController().userId = auth.currentUser!.uid.toString();
              ref.child(auth.currentUser!.uid).set({
                'uid' : auth.currentUser!.uid,
                'email' : auth.currentUser!.email,
                'password' : password,
                'onlineStatus' : 'noOne',
                'phone' : '',
                'userName' : userName,
                'profile' : '',
                'cover' : '',
              }).then((value) {
                setLoading(false);
                Navigator.pushNamedAndRemoveUntil(context, RouteName.dashboardScreen, (route) => false);
              }).onError((error, stackTrace) {
                setLoading(false);
                Utils.toastMessage(error.toString());
              });
            }else if(timer.tick == 20){
              timer.cancel();
              Utils.toastMessage("You didn't verify your account");
              auth.currentUser!.delete();
            }else{
              print(timer.tick);
            }
          });
        }).onError((error, stackTrace){
          setLoading(false);
          Utils.toastMessage(error.toString());
        });

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
