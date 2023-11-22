
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/message.dart';
import '../../models/room.dart';
import '../../providers/my_provider.dart';
import '../../shared/base.dart';
import 'chat_viewmodel.dart';
import 'message_widget.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = "chat";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseView<ChatScreen, ChatViewModel>
    implements ChatNavigator {
  var messageController = TextEditingController();

  @override
  ChatViewModel initViewModel() {
    // TODO: implement initViewModel
    return ChatViewModel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)!.settings.arguments as Room;
    var provider = Provider.of<MyProvider>(context);
    viewModel.myUser = provider.myUser!;
    viewModel.room = room;
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
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Text(room.roomName),
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 36),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                      child: StreamBuilder<QuerySnapshot<Message>>(
                        stream: viewModel.getMessages(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text("something went wrong"));
                          }
                          var messages =
                          snapshot.data?.docs.map((e) => e.data()).toList();

                          return ListView.builder(
                            itemBuilder: (context, index) {
                              return MessageWidget(messages![index]);
                            },
                            itemCount: messages?.length ?? 0,
                          );
                        },
                      )),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: messageController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: "type a message",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                  ),
                                  borderSide: BorderSide(color: Colors.blue)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                  ),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2))),
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            viewModel.sendMessage(messageController.text);
                          },
                          child: Row(
                            children: [
                              Text("Send"),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.send)
                            ],
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void clearMessage() {
    // TODO: implement clearMessage
    messageController.clear();
  }
}