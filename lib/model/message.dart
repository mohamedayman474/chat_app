class Message{
  static const String collectionName='messages';
  String id;
  String roomId;
  String content;
  DateTime dateTime;
  String senderName;
  String senderId;
  Message({
    this.id='',
    required this.roomId,
    required this.content,
    required this.dateTime,
    required this.senderName,
    required this.senderId
});
  Message.fromFireStore(Map<String,dynamic> json):this(
    id: json['id'] as String,
    roomId: json['roomId'] as String,
    content: json['content'] as String,
    dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime'] as int),
    senderName: json['senderName'] as String,
    senderId: json['senderId'] as String,
  );
  Map<String,dynamic> toFireStore(){
    return{
      'id':id,
      'roomId':roomId,
      'content':content,
      'dateTime':dateTime.millisecondsSinceEpoch,
      'senderName':senderName,
      'senderId':senderId,

    };

  }


}