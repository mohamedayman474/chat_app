import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/ui/home/home_Screen.dart';
import 'package:chat_app/ui/login/login_screen.dart';
import 'package:chat_app/ui/register/navigator.dart';
import 'package:chat_app/ui/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../base.dart';

class RegisterScreen extends StatefulWidget  {
  static String routeName = 'register screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen,RegisterViewModel> implements RegisterNavigator{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();



  String firstName = '';

  String lastName = '';

  String userName = '';

  String email = '';

  String password = '';


  @override
  void initState() {
    super.initState();
    viewModel.navigator=this;
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/background_image.png',
              fit: BoxFit.fill,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Container(margin: const EdgeInsets.only(top: 25),
                child: Text(
                  'Create Account',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
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
                      TextFormField(
                        decoration: InputDecoration(labelText: 'First Name'),
                        onChanged: (text) {
                          firstName = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter first name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Last Name'),
                        onChanged: (text) {
                          lastName = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter last name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'User Name'),
                        onChanged: (text) {
                          userName = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter user name';
                          }
                          if (text.contains(' ')) {
                            return 'user name must not contains white spaces ';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          onChanged: (text) {
                            email = text;
                          },
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please enter email';
                            }
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(text);
                            if (!emailValid) {
                              return 'email format not valid';
                            }
                            return null;
                          }),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Password'),
                        onChanged: (text) {
                          password = text;
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
                Container(margin: EdgeInsets.symmetric(vertical: 25),
                  child:ElevatedButton(
                          onPressed: () {
                            validateForm();
                          },
                          child: const Text('Create Account'))),
                      InkWell(
                          onTap: (){
                            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                          },

                          child: const Text("Already have an account ? ")),
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

  void validateForm() {
    if (formKey.currentState?.validate() == true) {
      viewModel.register(email, password,firstName,lastName,userName);
    }
  }

@override
  RegisterViewModel initViewModel(){
    return RegisterViewModel();
}

  @override
  void goToHome(MyUser user) {
    hideDialog();
    var userProvider=Provider.of<UserProvider>(context,listen: false);
    userProvider.user=user;
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }

}
