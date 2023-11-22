
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../database/database_utils.dart';
import '../models/my_user.dart';

class MyProvider extends ChangeNotifier {
  MyUser? myUser;
  late User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initMyUser();
    }
  }

  void initMyUser() async {
    myUser = await DataBaseUtils.readUser(firebaseUser?.uid ?? "");
  }
}