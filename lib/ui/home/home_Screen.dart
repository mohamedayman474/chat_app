import 'package:chat_app/base.dart';
import 'package:chat_app/ui/add_room/add_room_screen.dart';
import 'package:chat_app/ui/home/home_view_model.dart';
import 'package:chat_app/ui/home/navigator.dart';
import 'package:chat_app/ui/home/room_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {

static String routeName='home screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen,HomeViewModel> implements HomeNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.navigator=this;
    viewModel.getRooms();
  }
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (_)=>viewModel,
      child: Stack(
        children: [
        Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Image.asset('assets/images/background_image.png',fit: BoxFit.fill,),
      ),Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text('Chat App',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed(AddRoomScreen.routeName);
            },
          ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(child:Consumer<HomeViewModel>(
                    builder: (buildContext,homeViewModel,_){
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1
                        ),
                        itemBuilder: (_,index){
                        return RoomWidget(homeViewModel.rooms[index]);
                      },
                      itemCount: homeViewModel.rooms.length,);
                    },
                  ))
                ],
              ),
            ),

          ),
  ]
      ),
    );
  }

  @override
  HomeViewModel initViewModel()=>HomeViewModel();
}
