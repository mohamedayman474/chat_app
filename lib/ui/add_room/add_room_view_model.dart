import 'package:chat_app/base.dart';
import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/ui/add_room/navigator.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator>{
  void creeteRoom(String roomTitle,String roomDesc,String catId)async{
    String? message=null;
    try{
      var res=await DatabaseUtils.createRoom(roomTitle, roomDesc, catId);
    }catch(ex){
      message='Something went wrong';

    }
    navigator?.hideDialog();
    if(message!=null){
      navigator?.showMessage(message);
    }else{
      navigator?.roomCreated();
    }



  }
}