import 'package:chat_app/screens/creat_account/creat_account_navigator.dart';
import 'package:chat_app/screens/home_screen/home_view.dart';
import 'package:chat_app/screens/login/login_view.dart';
import 'package:chat_app/shared/base.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/my_user.dart';
import '../../providers/my_provider.dart';
import 'creat_account_view_model.dart';

class CreatAccount extends StatefulWidget{
  CreatAccount({super.key});
  static const routeName = "CreatAccount";

  @override
  State<CreatAccount> createState() => _CreatAccountState();
}

class _CreatAccountState extends BaseView<CreatAccount,CreateAccountViewModel>
implements CreateAccountNavigator{
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController=TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    viewModel.navigator=this;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          const Image(image: AssetImage("assets/images/bg.png")),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: const Text("Creat account"),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: firstNameController,
                      validator: (value) {
                        if (value == null || value == "") {
                          return "please enter first name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "first name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.blue))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
    controller:lastNameController,
    validator: (value) {
                        if (value == null || value == "") {
                          return "please enter last name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "last name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.blue))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(

                    controller:emailController,
                      validator: (value) {
                        if (value == null || value == "") {
                          return "please enter email";
                        }


                        final bool emailValid =
                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return "please enter Valid email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.blue))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value == "") {
                          return "please enter valid password";
                        }
                        return null;
                      },
                      obscureText: true,

                      decoration: InputDecoration(

                          hintText: "password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.blue))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(onPressed: () {
                      ValidateForm();
                    }, child: const Text("Creat")),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(child: Text("I have an account ?",
                    style: TextStyle(color: Colors.blue)),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, LoginView.routeName);
                    },)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ValidateForm()async {

    if (formKey.currentState!.validate()) {
      viewModel.creatAccount(emailController.text,
          passwordController.text,
          firstNameController.text,
          lastNameController.text,
          userNameController.text);

    }
  }



  @override
  CreateAccountViewModel initViewModel() {
    return CreateAccountViewModel();
  }

  @override
  void goToHome(MyUser user) {
    var provider = Provider.of<MyProvider>(context, listen: false);
    Navigator.pushReplacementNamed(context, HomeScreenView.routeName);  }
}
