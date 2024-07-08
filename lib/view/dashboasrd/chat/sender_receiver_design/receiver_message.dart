import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ReceiverMessage extends StatelessWidget {
  final String message;
  final String date;

  const ReceiverMessage({super.key, required this.message, required this.date});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final myDate = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
    final finalDate = DateFormat('hh:mm a').format(myDate);
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10, right: 30, top: 5, bottom: 20,
                ),
                child: Text(message, style: const TextStyle(fontSize: 16),),
              ),
              Positioned(
                bottom: 2,
                right: 10,
                child: Row(
                  children: [
                    Text(finalDate, style: const TextStyle(fontSize: 13,color: Colors.black),),
                    const SizedBox(width: 5,),
                    // const Icon(Icons.done_all,size: 20,color: Colors.blueAccent,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
