import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseViewModel<T extends BaseNavigator> extends ChangeNotifier {
  T? navigator=null;
}


abstract class BaseNavigator{
  void showLoding({String message});
  void hideDialog();
  void  showMessage(String message);
}


abstract class BaseView<T extends StatefulWidget,VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {

  late VM viewModel;
  VM initViewModel();
  @override
  void initState() {
    super.initState();
    viewModel= initViewModel();

  }
  @override
  hideDialog() {
    Navigator.pop(context);
  }

  @override
  void showLoding({String message="Loading..."}) {
    showDialog(context: context, builder: (context) {
      return  AlertDialog(
        title :Center(
          child: Row(
            children: [
              CircularProgressIndicator(),
              Text(message)
            ],
          ),
        ),);
    },);
  }

  @override
  showMessage(String message) {
    showDialog(context: context, builder: (context) {
      return  AlertDialog(
        title :Center(
          child: Text(message),
        ),);
    });
  }
}


