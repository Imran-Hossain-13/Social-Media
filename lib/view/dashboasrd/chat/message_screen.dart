import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:untitled/res/color.dart';
import 'package:untitled/view/dashboasrd/chat/sender_receiver_design/receiver_message.dart';
import 'package:untitled/view/dashboasrd/chat/sender_receiver_design/sender_message.dart';
import 'package:untitled/view_model/splash_services/session_manager.dart';
import '../../../utils/utils.dart';

class MessageScreen extends StatefulWidget {
  final String image, name, email, receiverId;
  const MessageScreen({
    super.key,
    required this.image,
    required this.name,
    required this.email,
    required this.receiverId,
  });

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref().child("chat");
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios,size: 35,),
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(widget.image),
            ),
            const SizedBox(width: 20,),
            Text(widget.name,style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 23),),
          ],
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: FirebaseAnimatedList(
                query: ref,
                defaultChild: const Center(child: CircularProgressIndicator(),),
                itemBuilder: (context, snapshot, animation, index){
                  if(snapshot.child('sender').value.toString() == SessionController().userId){
                    return SenderMessage(message: snapshot.child('message').value.toString(), date: snapshot.child('time').value.toString());
                  }
                  return ReceiverMessage(message: snapshot.child('message').value.toString(), date: snapshot.child('time').value.toString());
                },
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Row(
                  children: [
                    Expanded(child: TextFormField(
                      controller: messageController,
                      cursorColor: AppColors.primaryTextTextColor,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 19,height: 0),
                      decoration: InputDecoration(
                        hintText: "Enter message",
                        hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(color: AppColors.primaryTextTextColor.withOpacity(0.8),height: 0),
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(color: AppColors.textFieldDefaultFocus,)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(510),
                            borderSide: const BorderSide(color: AppColors.secondaryColor,width: 2)
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(color: AppColors.alertColor,width: 2)
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(color: AppColors.textFieldDefaultBorderColor,width: 2)
                        ),
                      ),
                    )),
                    const SizedBox(width: 5,),
                    InkWell(
                      onTap: (){
                        sendMessage();
                      },
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.primaryIconColor,
                        child: Center(child: Icon(Icons.send,color: AppColors.whiteColor,size: 30,)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  sendMessage(){
    if(messageController.text.isEmpty){
      Utils.toastMessage("Please write a message");
    }else{
      final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      ref.child(timeStamp).set({
        'isSeen' : false,
        'message' : messageController.text.toString(),
        'sender' : SessionController().userId.toString(),
        'receiver' : widget.receiverId,
        'type' : 'text',
        'time' : timeStamp.toString(),
      }).then((value) {messageController.clear();}).onError((error, stackTrace) {messageController.clear();});
    }
  }
}
