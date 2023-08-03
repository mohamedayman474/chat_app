import 'package:chat_app/base.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/ui/chat/chat_view_model.dart';
import 'package:chat_app/ui/message_widget/message_widget.dart';
import 'package:chat_app/ui/chat/navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static String routeName = 'chat screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseState<ChatScreen, ChatViewModel>
    implements ChatNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  ChatViewModel initViewModel() => ChatViewModel();
  String messageContent='';
  var textController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    Room room = ModalRoute.of(context)!.settings.arguments as Room;
    viewModel.room=room;
    var userProvider=Provider.of<UserProvider>(context);
    viewModel.currentUser=userProvider.user!;
    viewModel.listenForRoomUpdates();
    return ChangeNotifierProvider(
      create: (_)=>viewModel,
      child: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Image.asset(
            'assets/images/background_image.png',
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(room.title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,
              vertical: MediaQuery.of(context).size.height*0.05),
          decoration:BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color:  Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 7,
                    offset: const Offset(0,3)
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(12)
          ),
          child: Column(
            children: [
              Expanded(child: StreamBuilder<QuerySnapshot<Message>>(
                stream: viewModel.messagesStream,
                builder: (_,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator());
                  }
                  else if(snapshot.hasError){
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  var messages=snapshot.data?.docs.map((doc) => doc.data()).toList();
                  return ListView.builder(itemBuilder: (_,index){
                    return MessageWidget(messages!.elementAt(index));

                  },itemCount: messages?.length??0,);

                },
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                  controller: textController

                        ,onChanged: (text){
                          messageContent=text;
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(4),
                          hintText: 'Type your message',
                          border: OutlineInputBorder(

                            borderRadius: BorderRadius.only(topRight: Radius.circular(12)),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 0.5
                            )
                          )

                        ),
                      ),
                    ),
                    const SizedBox(width: 8,),
                    ElevatedButton(onPressed: (){
                      viewModel.sendMessage(messageContent);
                    }, child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Send'),
                        SizedBox(width: 8,),
                        Icon(Icons.send),
                      ],
                    ))
                  ],
                ),
              )
            ],
          ),
        ),)
      ]),
    );
  }

  @override
  void clearMessageText() {
    textController.clear();

  }
}
