import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import '../../models/message.dart';
import '../../providers/my_provider.dart';



class MessageWidget extends StatelessWidget {
  Message message;

  MessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return provider.myUser!.id == message.senderId
        ? SenderMessage(message)
        : ReciverMessage(message);
  }
}

class SenderMessage extends StatelessWidget {
  Message message;

  SenderMessage(this.message);

  @override
  Widget build(BuildContext context) {
    int ts = message.dateTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);

    var date = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),
                      topLeft: Radius.circular(18),
                      bottomLeft: Radius.circular(18))),
              child: Text(message.content)),
          Text(date.substring(12))
        ],
      ),
    );
  }
}

class ReciverMessage extends StatelessWidget {
  Message message;

  ReciverMessage(this.message);

  @override
  Widget build(BuildContext context) {
    int ts = message.dateTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);

    var date = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),
                      topLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18))),
              child: Text(message.content)),
          Text(date.substring(12))
        ],
      ),
    );
  }
}