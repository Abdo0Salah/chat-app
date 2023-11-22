import 'package:flutter/material.dart';

import '../../models/room.dart';
import '../chat/chat_screen.dart';

class RoomWidget extends StatelessWidget {
  Room room;

  RoomWidget(this.room);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChatScreen.routeName, arguments: room);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(horizontal: 16),
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
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset("assets/images/${room.catId}.jpeg")),
            SizedBox(
              height: 10,
            ),
            Text(room.roomName)
          ],
        ),
      ),
    );
  }
}