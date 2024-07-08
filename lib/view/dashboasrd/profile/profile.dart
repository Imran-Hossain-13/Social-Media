import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:untitled/res/color.dart';
import 'package:untitled/res/components/round_button.dart';
import 'package:untitled/utils/utils.dart';
import 'package:untitled/view/login/login_screen.dart';
import 'package:untitled/view_model/profile_controller/profile_controller.dart';
import '../../../view_model/splash_services/session_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref("users");

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ChangeNotifierProvider(
        create: (_) => ProfileController(),
        child: Consumer<ProfileController>(
          builder: (context, provider, child){
            return Column(
              children: [
                Expanded(child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (context,AsyncSnapshot<DatabaseEvent> snapshot){
                    if(snapshot.hasData){
                      Map<dynamic, dynamic> dataMap = snapshot.data!.snapshot.value as dynamic;
                      List<dynamic> dataList = [];
                      dataList.clear();
                      dataList = dataMap.values.toList();
                      for(int i = 0; i != snapshot.data!.snapshot.children.length; i++){
                        print(i);
                        if(auth.currentUser!.email.toString() == dataList[1]['email'].toString()){
                          provider.setIndex(i);
                        }
                        // print(auth.currentUser!.email);
                        // print(dataList[index]['email'].toString());
                        // print(i);
                      }
                      return Column(
                        children: [
                          SizedBox(
                            height: height * .34,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              clipBehavior: Clip.none,
                              children: [
                                SizedBox(
                                    width: width,
                                    height: height * .28,
                                    child: Container(
                                      color: Colors.grey.shade400,
                                      child: provider.coverImage == null?dataList[provider.index]['cover'] == ''?Container():
                                        Image.network(dataList[provider.index]['cover'],fit: BoxFit.cover,)
                                        :Image.file(File(provider.coverImage!.path).absolute,fit: BoxFit.cover,),
                                    )
                                ),
                                Positioned(
                                    top: height * .23,
                                    right: 20,
                                    child: InkWell(
                                      onTap: (){
                                        provider.pickImage(context,2);
                                      },
                                      child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.circular(50)
                                          ),
                                          child: const Icon(Icons.add,color: AppColors.whiteColor,)
                                      ),
                                    )
                                ),
                                Positioned(
                                  top: height * .15,
                                  child: provider.profileImage == null?dataList[provider.index]['profile'] == ''?
                                      const CircleAvatar(
                                        radius: 100,
                                        child: Center(child: Icon(Icons.person_outline,size: 130,color: Colors.white,),),
                                      ):
                                      CircleAvatar(
                                        radius: 100,
                                        backgroundImage: NetworkImage(dataList[provider.index]['profile']),
                                      ):
                                      CircleAvatar(
                                        radius: 100,
                                        backgroundImage: FileImage(File(provider.profileImage!.path).absolute),
                                      ),
                                ),
                                Positioned(
                                  top: height * .31,
                                  child: InkWell(
                                    onTap: (){
                                      provider.pickImage(context,1);
                                    },
                                    child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(50)
                                        ),
                                        child: const Icon(Icons.add,color: AppColors.whiteColor,)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: height * .08,),
                          GestureDetector(
                              onTap: (){
                                ProfileController.showUserNameDialog(context, dataList[provider.index]['userName']);
                              },
                              child: MyList(icon: Icons.person_outline, title: "Username", data: dataList[provider.index]['userName'],)
                          ),
                          GestureDetector(
                              onTap: (){
                                ProfileController.showUserPhoneDialog(context, dataList[provider.index]['phone']);
                              },
                              child: MyList(icon: Icons.phone, title: "Phone", data: dataList[provider.index]['phone'] == ''?"01XXXXXXXX":dataList[provider.index]['phone'])
                          ),
                          MyList(icon: Icons.email_outlined, title: "Email", data: dataList[provider.index]['email'],),
                          SizedBox(height: height * .06,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: RoundButton(
                              onTap: (){
                                auth.signOut().then((value) {
                                  Utils.toastMessage("Log out successfully");
                                  // Navigator.pushNamedAndRemoveUntil(context, RouteName.loginView, (route) => false);
                                  PersistentNavBarNavigator.pushNewScreen(context, screen: const LoginScreen(),withNavBar: false);
                                  SessionController().userId = null;
                                }).onError((error, stackTrace){
                                  Utils.toastMessage(error.toString());
                                });
                              },
                              title: "Log out",
                            ),
                          ),
                          SizedBox(height: height * .02,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: RoundButton(
                              onTap: (){
                                if(provider.profileImage != null){
                                  provider.uploadProfileImage();
                                }else if(provider.coverImage != null){
                                  provider.uploadCoverImage();
                                }else{
                                  Utils.toastMessage("Please select an image");
                                }
                              },
                              title: "Upload Image",
                              loading: provider.loading,
                            ),
                          ),
                          // InkWell(
                          //   onTap: (){
                          //     auth.signOut().then((value) {
                          //       Utils.toastMessage("Log out successfully");
                          //       // Navigator.pushNamedAndRemoveUntil(context, RouteName.loginView, (route) => false);
                          //       PersistentNavBarNavigator.pushNewScreen(context, screen: const LoginScreen(),withNavBar: false);
                          //       SessionController().userId = null;
                          //     }).onError((error, stackTrace){
                          //       Utils.toastMessage(error.toString());
                          //     });
                          //   },
                          //   child: Container(
                          //     height: 50,
                          //     margin: const EdgeInsets.symmetric(horizontal: 10),
                          //     decoration: BoxDecoration(
                          //       color: Colors.black,
                          //       borderRadius: BorderRadius.circular(20),
                          //     ),
                          //     child: const Center(child: Text("Log out",style: TextStyle(color: Colors.white,fontSize: 23),),),
                          //   ),
                          // ),
                        ],
                      );
                    }else{
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )),
              ],
            );
          },
        ),
      ),
    );
  }
}

class MyList extends StatelessWidget {
  final IconData icon;
  final String title;
  final String data;
  const MyList({
    super.key, required this.icon, required this.title, required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon,size: 30,),
              const SizedBox(
                width: 30,
              ),
              Text(title),
            ],
          ),
          Text(data)
        ],
      ),
    );
  }
}
