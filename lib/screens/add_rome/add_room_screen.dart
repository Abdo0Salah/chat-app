
import 'package:flutter/material.dart';


import '../../models/room_category.dart';
import '../../shared/base.dart';
import 'add_room_navigator.dart';
import 'add_room_viewmodel.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = "AddRoom";

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseView<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigator {
  var roomNameController = TextEditingController();

  var roomDescriptionController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var categories = RoomCategory.getCategories();
  late RoomCategory selectedCategory;

  @override
  AddRoomViewModel initViewModel() => AddRoomViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    selectedCategory = categories.first;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/bg.png',
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title: Text('Add Room'),
          ),
          body: SingleChildScrollView(
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 64),
              elevation: 16,
              shape: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Create New Room",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 22),
                      ),
                      Image.asset("assets/images/create_room_bg.png"),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: roomNameController,
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return "Please Enter Room name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Room name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DropdownButton<RoomCategory>(
                        value: selectedCategory,
                        items: categories
                            .map((cat) => DropdownMenuItem<RoomCategory>(
                            value: cat,
                            child: Row(
                              children: [
                                Image.asset(cat.image),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(cat.name)
                              ],
                            )))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: roomDescriptionController,
                        decoration: InputDecoration(
                          hintText: "Room description",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue)),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return "Please Enter Room description";
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
                          child: Text('Create')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void ValidateForm() {
    if (formKey.currentState!.validate()) {
      viewModel.CreateRoom(roomNameController.text,
          roomDescriptionController.text, selectedCategory.id);
    }
  }

  @override
  void roomCreated() {
    // TODO: implement roomCreated
    Navigator.pop(context);
  }
}