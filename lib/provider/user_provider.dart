import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  MyUser? user;
  User? firebaseUser;
  UserProvider(){
    firebaseUser=FirebaseAuth.instance.currentUser;
    initUser();
  }
  void initUser()async{
    if(firebaseUser!=null){
     user= await DatabaseUtils.readUser(firebaseUser?.uid?? "");
    }
  }
}