import 'package:chat_app/model/message.dart';
import 'package:chat_app/ui/message_widget/message_widget.dart';
import 'package:flutter/material.dart';



class ReceivedMessage extends StatelessWidget {

  
  Message message;
  ReceivedMessage(this.message);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12),bottomRight: Radius.circular(12))
            ),
            child: Text(message.content,style: TextStyle(color: Colors.black),),
          ),
          Text(message.dateTime.toString()),

        ],
      ),
    );
  }
}