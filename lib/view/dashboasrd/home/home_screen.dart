import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../res/color.dart';
import '../profile/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("users");

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset("assets/images/logo.png",width: 50,),
            const SizedBox(width: 15,),
            Text("Seed",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 25),)
          ],
        ),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (con) =>const ProfileScreen()));
              },
              icon: const Icon(Icons.menu,size: 40,)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Expanded(child: FirebaseAnimatedList(
              query: ref,
              defaultChild: const Center(child: CircularProgressIndicator(),),
              itemBuilder: (context, snapshot, animation, index){
                if(snapshot.child('cover').value.toString() == ''){
                  return Container();
                }else{
                  return Container(
                    width: width,
                    height: 460,
                    margin: const EdgeInsets.only(bottom: 30),
                    decoration: BoxDecoration(
                        color: AppColors.listTileColor,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            const SizedBox(width: 20,),
                            snapshot.child('profile').value.toString() == ''?
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey.shade400,
                                child: Icon(Icons.person_outline,color: Colors.grey.shade700,size: 40,),
                              ):
                              CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(snapshot.child('profile').value.toString()),
                            ),
                            const SizedBox(width: 20,),
                            Text(snapshot.child('userName').value.toString(),style: Theme.of(context).textTheme.headlineMedium!.copyWith(),)
                          ],
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                          width: width,
                          height: 380,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(snapshot.child('cover').value.toString(),fit: BoxFit.cover,)
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            )),

          ],
        ),
      ),
    );
  }
}
