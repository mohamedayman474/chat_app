import 'package:chat_app/model/message.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/ui/message_widget/received_message.dart';
import 'package:chat_app/ui/message_widget/sent_message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class MessageWidget extends StatelessWidget {

  Message message;
  MessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    var userProvider=Provider.of<UserProvider>(context);

    return userProvider.user?.id == message.senderId ?
    SentMessage(message): ReceivedMessage(message);
  }
}








