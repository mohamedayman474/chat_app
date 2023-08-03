import 'package:chat_app/base.dart';
import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/ui/chat/navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator>{
  late Room room;
  late MyUser currentUser;
  late Stream<QuerySnapshot<Message>> messagesStream;
  void listenForRoomUpdates(){
   messagesStream= DatabaseUtils.getMessageStream(room.id);
  }
void sendMessage(String messageContent)async{
  if(messageContent.trim().isEmpty){
    return;
  }
  var message=Message(roomId:room.id , content: messageContent,
      dateTime:DateUtils.dateOnly(DateTime.now()) ,
      senderName: currentUser.userName, senderId: currentUser.id);
try{
  var res=await DatabaseUtils.insertMessageToRoom(message);
  navigator?.clearMessageText();
}catch(error){
  navigator?.showMessage(error.toString());

}

}

}