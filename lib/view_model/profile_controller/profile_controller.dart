import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/res/color.dart';
import 'package:untitled/res/components/input_text_field.dart';
import 'package:untitled/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:untitled/view_model/splash_services/session_manager.dart';

class ProfileController with ChangeNotifier{
  static FirebaseAuth auth = FirebaseAuth.instance;
  static DatabaseReference ref = FirebaseDatabase.instance.ref().child('users');
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;


  static final nameController = TextEditingController();
  static final phoneController = TextEditingController();

  static final nameFocusNode = FocusNode();
  static final phoneFocusNode = FocusNode();

  bool _loading = false;
  bool get loading => _loading;
  int _index = 0;
  int get index => _index;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  setIndex(int index){
    _index = index;
  }

  final picker = ImagePicker();
  XFile? _profileImage;
  XFile? get profileImage => _profileImage;
  XFile? _coverImage;
  XFile? get coverImage => _coverImage;

  Future pickGalleryImage(BuildContext context, int selector) async{
    // selector value 1 for profile, 2 for cover
    final pickFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if(pickFile != null){
      if(selector == 1){
        _profileImage = XFile(pickFile.path);
        notifyListeners();
      }else{
        _coverImage = XFile(pickFile.path);
        notifyListeners();
      }
    }
  }

  Future pickCameraImage(BuildContext context, int selector) async{
    // selector value 1 for profile, 2 for cover
    final pickFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if(pickFile != null){
      if(selector == 1){
        _profileImage = XFile(pickFile.path);
        notifyListeners();
      }else{
        _coverImage = XFile(pickFile.path);
        notifyListeners();
      }
    }
  }

  void pickImage(BuildContext context, int selector){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            content: SizedBox(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: (){
                      pickCameraImage(context, selector);
                      Navigator.pop(context);
                    },
                    leading: const Icon(Icons.camera_alt),
                    title: const Text("Camera"),
                  ),
                  ListTile(
                    onTap: (){
                      pickGalleryImage(context, selector);
                      Navigator.pop(context);
                    },
                    leading: const Icon(Icons.image_rounded),
                    title: const Text("Gallery"),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  void uploadProfileImage() async{
    setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref('/profileImage${SessionController().userId}');
    firebase_storage.UploadTask uploadTask = storageRef.putFile(File(profileImage!.path).absolute);

    await Future.value(uploadTask);

    final newUrl = await storageRef.getDownloadURL();

    ref.child(SessionController().userId.toString()).update({
      'profile' : newUrl.toString(),
    }).then((value){
      setLoading(false);
      Utils.toastMessage("Profile uploaded successfully");
      _profileImage = null;
    }).onError((error, stackTrace){
      setLoading(false);
      Utils.toastMessage(error.toString());
      _profileImage = null;
    });
  }

  void uploadCoverImage() async{
    setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref('/coverImage${SessionController().userId}');
    firebase_storage.UploadTask uploadTask = storageRef.putFile(File(coverImage!.path).absolute);

    await Future.value(uploadTask);

    final newUrl = await storageRef.getDownloadURL();

    ref.child(SessionController().userId.toString()).update({
      'cover' : newUrl.toString(),
    }).then((value){
      setLoading(false);
      Utils.toastMessage("Cover photo uploaded successfully");
      _coverImage = null;
    }).onError((error, stackTrace){
      setLoading(false);
      Utils.toastMessage(error.toString());
      _coverImage = null;
    });
  }


  static Future<void> showUserNameDialog(BuildContext context,String name){
    nameController.text = name;
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Center(child: Text("You didn't change the number")),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextField(
                      myController: nameController,
                      focusNode: nameFocusNode,
                      onFieldSubmittedValue: (value){ },
                      onValidator: (c){  },
                      keyboardType: TextInputType.text,
                      hint: "Username",
                      obscureText: false
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Cancel",style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.alertColor),),
              ),
              TextButton(
                onPressed: (){
                  if(name == nameController.text){
                    Utils.toastMessage("you didn't change username");
                    Navigator.pop(context);
                  }else{
                    ref.child(auth.currentUser!.uid).update({
                      'userName' : nameController.text,
                    }).then((value){
                      nameController.clear();
                      Utils.toastMessage("Username updated");
                    }).onError((error, stackTrace){
                      Utils.toastMessage("Something is wrong");
                      Utils.toastMessage("Please try again");
                    });
                    Navigator.pop(context);
                  }
                }, child: Text("Ok",style: Theme.of(context).textTheme.subtitle1!,),
              ),
            ],
          );
        }
    );
  }

  static Future<void> showUserPhoneDialog(BuildContext context,String phoneNumber){
    phoneController.text = phoneNumber;
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Center(child: Text("Update username")),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextField(
                      myController: phoneController,
                      focusNode: phoneFocusNode,
                      onFieldSubmittedValue: (value){ },
                      onValidator: (c){ },
                      keyboardType: TextInputType.number,
                      hint: "Phone number",
                      obscureText: false
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Cancel",style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.alertColor),),
              ),
              TextButton(
                onPressed: (){
                  if(phoneNumber == phoneController.text){
                    Utils.toastMessage("You didn't change the number");
                    Navigator.pop(context);
                  }else{
                    ref.child(auth.currentUser!.uid).update({
                      'phone' : phoneController.text,
                    }).then((value){
                      phoneController.clear();
                      Utils.toastMessage("Number updated");
                    }).onError((error, stackTrace){
                      Utils.toastMessage("Something is wrong");
                      Utils.toastMessage("Please try again");
                    });
                    Navigator.pop(context);
                  }
                }, child: Text("Ok",style: Theme.of(context).textTheme.subtitle1!,),
              ),
            ],
          );
        }
    );
  }
}