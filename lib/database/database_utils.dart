import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseUtils{
  static CollectionReference<MyUser> getUsersCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(fromFirestore: (snapshot,_)=>MyUser.fromJson(snapshot.data()!)
        , toFirestore: (user,_)=>user.toJson());
  }
  static CollectionReference<Room> getRoomsCollection(){
    return FirebaseFirestore.instance.collection(Room.collectionName)
        .withConverter<Room>(fromFirestore: (snapshot,_)=>Room.fromJson(snapshot.data()!)
        , toFirestore: (room,_)=>room.toJson());
  }
static CollectionReference<Message> getMessagesCollection(String roomId){
    return getRoomsCollection().doc(roomId)
        .collection(Message.collectionName)
        .withConverter(fromFirestore: (snapshot,_)=>Message.fromFireStore(snapshot.data()!),
        toFirestore: (message,_)=>message.toFireStore());
}
  static Future<void> createDBUsers(MyUser user)async{

   getUsersCollection()
        .doc(user.id)
        .set(user);
  }
  static Future<MyUser?> readUser(String userId)async{
    var userDocSnapshot= await getUsersCollection()
        .doc(userId)
        .get();
   return userDocSnapshot.data();
  }
  static Future<void>createRoom(String title,String desc,String catId){
    var roomsCollection= getRoomsCollection();
        var docRef= roomsCollection.doc();
        Room room=Room(id: docRef.id, title: title, desc: desc, catId: catId);
        return docRef.set(room);

  }
  static Future<List<Room>> getRoomsFromFirestore()async {
    var qsnapshot=await getRoomsCollection()
        .get();
    return qsnapshot.docs.map((doc) => doc.data()).toList();

  }
  static Future<void> insertMessageToRoom(Message message)async{
    var roomMessage=getMessagesCollection(message.roomId);
   var docRef= roomMessage.doc();
   message.id=docRef.id;
  return docRef.set(message);


  }
  static Stream<QuerySnapshot<Message>> getMessageStream(String roomId){
   return getMessagesCollection(roomId)
   .orderBy('dateTime')
        .snapshots();
  }

}