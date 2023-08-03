import 'package:chat_app/model/message.dart';

import 'package:flutter/material.dart';

import 'message_widget.dart';

class SentMessage extends StatelessWidget {

  Message message;
  SentMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12),bottomLeft: Radius.circular(12))
            ),
            child: Text(message.content,style: const TextStyle(color: Colors.white),),
          ),
          Text("${message.dateTime.day}/${message.dateTime.month}/${message.dateTime.year}"),

        ],
      ),
    );
  }
}