import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:untitled/view/dashboasrd/chat/message_screen.dart';
import 'package:untitled/view_model/splash_services/session_manager.dart';
import '../../../res/color.dart';
import '../../../utils/utils.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("users");

  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: width,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * .8,
                        child: TextFormField(
                          controller: searchController,
                          cursorColor: Colors.grey,
                          onChanged: (value){

                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "Search name",
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: (){},
                          icon: const Icon(Icons.search,size: 30)
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30,),
                Expanded(
                  child: FirebaseAnimatedList(
                    query: ref,
                    defaultChild: const Center(child: CircularProgressIndicator(),),
                    itemBuilder: (context, snapshot, animation, index){
                      if(SessionController().userId == snapshot.child('uid').value.toString()){
                        return Container();
                      }else{
                        return GestureDetector(
                          onTap: (){
                            PersistentNavBarNavigator.pushNewScreen(
                                context,
                                withNavBar: false,
                                screen: MessageScreen(
                                    image: snapshot.child('profile').value.toString(),
                                    name: snapshot.child('userName').value.toString(),
                                    email: snapshot.child('email').value.toString(),
                                    receiverId: snapshot.child('userId').value.toString(),
                                )
                            );
                          },
                          child: Container(
                            width: width,
                            height: 70,
                            margin: const EdgeInsets.only(bottom: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                            decoration: BoxDecoration(
                                color: AppColors.listTileColor,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(width: 2,color: Colors.grey),
                                boxShadow: const [BoxShadow(
                                  color: AppColors.listTileColor,
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                )]
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade400,
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: snapshot.child('profile').value.toString() == ''?
                                      Center(child: Icon(Icons.person_outline,size: 35,color: Colors.grey.shade700,),):
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(snapshot.child('profile').value.toString()),
                                      ),
                                    ),
                                    const SizedBox(width: 30,),
                                    Text(snapshot.child('userName').value.toString())
                                  ],
                                ),
                                IconButton(
                                    onPressed: (){
                                      Utils.toastMessage("Request sent");
                                    },
                                    icon: const Icon(Icons.person_add,size: 35,)
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
