import 'package:chat_app/base.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/ui/home/home_Screen.dart';
import 'package:chat_app/ui/login/login_view_model.dart';
import 'package:chat_app/ui/login/navigator.dart';
import 'package:chat_app/ui/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String routeName='login screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen,LoginViewModel>  implements LoginNavigator {
  GlobalKey<FormState> formKey=GlobalKey<FormState>();

  String email='';

  String password='';
  @override
  void initState() {
    super.initState();
    viewModel.navigator=this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>viewModel,
      child: Stack(
        children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Image.asset('assets/images/background_image.png',fit: BoxFit.fill,),
        ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: const Text('Login',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
            ),
            body: SingleChildScrollView(
              child: Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
      padding: const EdgeInsets.all(12),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Welcome back!',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email'
                        ),
                        onChanged: (text){
                          email=text;
                        },
                        validator: (text){
                          if(text==null || text.trim().isEmpty){
                            return 'please enter email';
                          }
                          bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);
                          if (!emailValid) {
                            return 'email format not valid';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Password'
                        ),
                        onChanged: (text){
                          password=text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter password';
                          }
                          if (text.trim().length < 8) {
                            return 'password should be at least 8 chars';
                          }
                          return null;
                        },
                      ),
                      Container(margin: const EdgeInsets.symmetric(vertical: 25),
                        child: ElevatedButton(onPressed: (){
                          validateForm();
                        }, child: const Text('Login')),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
                        },

                          child: const Text("Don't have an account ? ")),



                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void validateForm(){
    if(formKey.currentState?.validate()==true){
      viewModel.login(email, password);

    }
  }

  @override
  LoginViewModel initViewModel() {
   return LoginViewModel();
  }

  @override
  void goToHome(MyUser user) {
    var userProvider=Provider.of<UserProvider>(context,listen: false);
    userProvider.user=user;
   Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
