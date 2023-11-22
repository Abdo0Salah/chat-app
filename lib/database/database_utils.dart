



import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message.dart';
import '../models/my_user.dart';
import '../models/room.dart';

class DataBaseUtils {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.COLLECTION_NAME)
        .withConverter<MyUser>(
      fromFirestore: (snapshot, options) =>
          MyUser.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    );
  }

  static CollectionReference<Message> getMessageCollection(String roomId) {
    return getRoomsCollection()
        .doc(roomId)
        .collection(Message.COLLECTION_NAME)
        .withConverter<Message>(
      fromFirestore: (snapshot, options) =>
          Message.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    );
  }

  static Future<void> addMessageToFirestore(Message message) {
    var docRef = getMessageCollection(message.roomId).doc();
    message.id = docRef.id;
    return docRef.set(message);
  }

  static Stream<QuerySnapshot<Message>> readMessagesFromFirestore(
      String roomId) {
    return getMessageCollection(roomId).orderBy("dateTime").snapshots();
  }

  static CollectionReference<Room> getRoomsCollection() {
    return FirebaseFirestore.instance
        .collection(Room.COLLECTION_NAME)
        .withConverter<Room>(
      fromFirestore: (snapshot, options) => Room.fromJson(snapshot.data()!),
      toFirestore: (room, options) => room.toJson(),
    );
  }

  static Future<void> AddRoomToFirestore(Room room) {
    var docRef = getRoomsCollection().doc();
    room.id = docRef.id;
    return docRef.set(room);
  }

  static Future<List<Room>> getRoomsFromFirestore() async {
    QuerySnapshot<Room> snapRoom = await getRoomsCollection().get();
    return snapRoom.docs.map((e) => e.data()).toList();
  }

  static Future<void> AddUserToFirestore(MyUser user) {
    return getUsersCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUser(String id) async {
    DocumentSnapshot<MyUser> docSnapShot =
    await getUsersCollection().doc(id).get();
    var myUser = docSnapShot.data();
    return myUser;
  }
}