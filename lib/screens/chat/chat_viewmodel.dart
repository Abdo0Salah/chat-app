
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../database/database_utils.dart';
import '../../models/message.dart';
import '../../models/my_user.dart';
import '../../models/room.dart';
import '../../shared/base.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  late Room room;
  late MyUser myUser;

  void sendMessage(String content) {
    if (content.trim().isEmpty) return;
    Message message = Message(
        content: content,
        dateTime: DateTime.now().millisecondsSinceEpoch,
        senderId: myUser.id,
        senderName: myUser.userName,
        roomId: room.id);
    DataBaseUtils.addMessageToFirestore(message).then((value) {
      navigator!.clearMessage();
    }).catchError((error) {
      navigator!.showMessage(error.toString());
    });
  }

  Stream<QuerySnapshot<Message>> getMessages() {
    return DataBaseUtils.readMessagesFromFirestore(room.id);
  }
}

abstract class ChatNavigator extends BaseNavigator {
  void clearMessage();
}