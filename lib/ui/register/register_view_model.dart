import 'package:chat_app/base.dart';
import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/firebase_errors.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/ui/register/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RegisterViewModel extends BaseViewModel<RegisterNavigator>{

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  void register(String email, String password,String firstName,String lastName,
      String userName)async{
    String? message;

    try {
      navigator?.showLoading(isDismissable: true);
      var result=await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user=MyUser(
          id: result.user?.uid??"",
          fName: firstName,
          lName: lastName,
          userName: userName,
          email: email);
      var task= await DatabaseUtils.createDBUsers(user);
      navigator?.goToHome(user);
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.weakPassword) {
        message='The password provided is too weak.';
      } else if (e.code == FirebaseErrors.email_in_use) {
        message='The account already exists for that email.';
      }
      else{
        message='Wrong email or password';
      }
    } catch (e) {
      message='something went wrong';
    }
    navigator?.hideDialog();
    if(message!=null){
      navigator?.showMessage(message);
    }

  }
}