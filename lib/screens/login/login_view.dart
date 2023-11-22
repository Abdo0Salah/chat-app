
import 'package:chat_app/screens/creat_account/creat_account_view.dart';
import 'package:chat_app/screens/home_screen/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/my_user.dart';
import '../../providers/my_provider.dart';
import '../../shared/base.dart';
import 'login_navigator.dart';
import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  static const String routeName = "login";

  @override
  State<LoginView> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginView, LoginViewModel>
    implements LoginNavigator {
  var passwordController = TextEditingController();

  var emailController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {

    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/bg.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Text('Login'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: emailController,
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return "Please Enter your Email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blue)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blue)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blue)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blue)),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return "Please Enter Last name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          ValidateForm();
                        },
                        child: Text('Login')),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, CreatAccount.routeName);
                        },
                        child: Text("Don't Have an account ?"))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void ValidateForm() async {
    if (formKey.currentState!.validate()) {
      viewModel.login(emailController.text, passwordController.text);
    }
  }

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  void goToHome(MyUser user) {
    var provider = Provider.of<MyProvider>(context, listen: false);

    Navigator.pushReplacementNamed(context, HomeScreenView.routeName);
  }
}