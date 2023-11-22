
import 'package:chat_app/screens/home_screen/rooom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/message.dart';
import '../../shared/base.dart';
import '../add_rome/add_room_screen.dart';
import '../login/login_view.dart';
import 'home_navigator.dart';
import 'home_view_model.dart';

class HomeScreenView extends StatefulWidget {
  static const String routeName = "Home";

  @override
  State<HomeScreenView> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseView<HomeScreenView, HomeViewModel>
    implements HomeNavigator {
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
            backgroundColor: Colors.transparent,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddRoomScreen.routeName);
setState(() {

});
              },
              child: Icon(Icons.add),
            ),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              title: Text("ChatApp"),
              actions: [
                IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(
                          context, LoginView.routeName);
                    },
                    icon: Icon(Icons.logout))
              ],
            ),
            body: Consumer<HomeViewModel>(
              builder: (_, homeViewModel, c) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    return RoomWidget(homeViewModel.rooms[index]);

                  },
                  itemCount: homeViewModel.rooms.length,
                );

              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    viewModel.getRooms();
  }

  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }
}