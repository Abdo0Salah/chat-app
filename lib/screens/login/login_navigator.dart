
import '../../models/my_user.dart';
import '../../shared/base.dart';

abstract class LoginNavigator extends BaseNavigator {
  void goToHome(MyUser user);
}