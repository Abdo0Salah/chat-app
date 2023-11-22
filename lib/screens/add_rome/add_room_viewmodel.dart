


import '../../database/database_utils.dart';
import '../../models/room.dart';
import '../../shared/base.dart';
import 'add_room_navigator.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {


  void CreateRoom(String roomName, String roomDescription, String catId) {
    Room room = Room(
        roomName: roomName, roomDescription: roomDescription, catId: catId);
    DataBaseUtils.AddRoomToFirestore(room).then((value) {
      navigator!.roomCreated();
    }).catchError((error) {
      navigator!.showMessage(error.toString());
    });
  }
}