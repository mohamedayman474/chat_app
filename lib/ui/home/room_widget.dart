import 'package:chat_app/model/room.dart';
import 'package:chat_app/ui/chat/chat_screen.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  Room room;
  RoomWidget(this.room, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(ChatScreen.routeName,
        arguments: room);
      },
      child: Container(
        decoration: BoxDecoration(
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
            Container(
              margin: const EdgeInsets.all(12),
              child: Image.asset('assets/images/${room.catId}.png',
              width: MediaQuery.of(context).size.width*0.2,
              fit: BoxFit.fitWidth,),
            ),

            Text(room.title)
          ],
        )
      ),
    );
  }
}
