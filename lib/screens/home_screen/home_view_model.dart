
import '../../database/database_utils.dart';
import '../../models/room.dart';
import '../../shared/base.dart';
import 'home_navigator.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  List<Room> rooms = [];

  void getRooms() {
    DataBaseUtils.getRoomsFromFirestore().then((value) {
      rooms = value;
    });
  }
}