import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/ui/add_room/add_room_screen.dart';
import 'package:chat_app/ui/chat/chat_screen.dart';
import 'package:chat_app/ui/home/home_Screen.dart';
import 'package:chat_app/ui/login/login_screen.dart';
import 'package:chat_app/ui/register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(create: (_)=>UserProvider())
    ],

      child: MyApp()));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var userProvider=Provider.of<UserProvider>(context);
    return MaterialApp(

      title: 'Chat-App',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      routes: {

        RegisterScreen.routeName:(_)=>RegisterScreen(),
        LoginScreen.routeName:(_)=>LoginScreen(),
        HomeScreen.routeName:(_)=>HomeScreen(),
        AddRoomScreen.routeName:(_)=>AddRoomScreen(),
        ChatScreen.routeName:(_)=>ChatScreen()
      },
      initialRoute: userProvider.firebaseUser==null ? LoginScreen.routeName :HomeScreen.routeName,
    );
  }
}
