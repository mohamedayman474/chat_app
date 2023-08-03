import 'package:chat_app/base.dart';
import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/firebase_errors.dart';
import 'package:chat_app/ui/login/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginViewModel extends BaseViewModel<LoginNavigator>{
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  void login(String email, String password)async{
    String? message;

    try {
      navigator?.showLoading(isDismissable: true);
    var result=await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    var userRes= await DatabaseUtils.readUser(result.user?.uid??"");
    if(userRes == null){
      message='Failed to complete sign in, please try again';

    }else{
      navigator?.goToHome(userRes);

    }
    } on FirebaseAuthException catch (e) {
     message='Wrong email or password';
    }catch (e) {
      message='something went wrong';
    }
    navigator?.hideDialog();
    if(message!=null){
      navigator?.showMessage(message);
    }


  }
}