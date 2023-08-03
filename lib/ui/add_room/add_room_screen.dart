import 'package:chat_app/base.dart';
import 'package:chat_app/model/category.dart';
import 'package:chat_app/ui/add_room/add_room_view_model.dart';
import 'package:chat_app/ui/add_room/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoomScreen extends StatefulWidget {
  static String routeName = 'add room';

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseState<AddRoomScreen,AddRoomViewModel> implements AddRoomNavigator {
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  var categories = Category.getCategories();
  late Category selectedItem;
  String roomTitle='';
  String roomDesc='';


  @override
  void initState() {
    super.initState();
    selectedItem=categories[0];
    viewModel.navigator=this;
  }

  @override
  Widget build(BuildContext context) {
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
            title: const Text('Chat App',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          body: SingleChildScrollView(
            child: Container(

              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin:const EdgeInsets.only(top: 20),
                        child: const Text('Create New Room',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                    Image.asset('assets/images/group.png'),
                    Container(
                      margin:const EdgeInsets.all(12),
                      child: TextFormField(
                        decoration:const InputDecoration(hintText: "Room Title"),
                        onChanged: (text){
                          roomTitle=text;
                        },
                        validator: (text){
                          if(text==null||text.trim().isEmpty){
                            return 'please enter room title';
                          }


                        },
                      ),
                    ),
                    Container(margin:const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButton<Category>(
                              value: selectedItem,
                                items: categories
                                    .map((cat) => DropdownMenuItem<Category>(
                                  value: cat,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Image.asset(cat.image,
                                      height: 50,
                                      width: 50,),
                                      const SizedBox(width: 12,),
                                      Text(cat.title)
                                    ],
                                  ),
                                ))
                                    .toList(),
                                onChanged: (cat){
                                  if(cat==null) return;
                                  setState((){
                                    selectedItem=cat;
                                  });

                                }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(12),
                      child: TextFormField(

                        minLines: 4,
                        maxLines: 4,
                        decoration: const InputDecoration(hintText: 'Description'),
                        onChanged: (text){
                          roomDesc=text;
                        },
                        validator: (text){
                          if(text==null||text.trim().isEmpty){
                            return 'please enter room description';
                          }


                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: ElevatedButton(onPressed: (){
                        validateForm();
                      },
                          child:const Text('Create')),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }

  void validateForm() {
    if(formKey.currentState?.validate()==true){
      viewModel.creeteRoom(roomTitle, roomDesc, selectedItem.id);

    }
  }

  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
  }

  @override
 void roomCreated() {
 showMessage('Room created successfully',actionName: 'Ok',action: (){
   hideDialog();
   Navigator.pop(context);
 });
  }


}
