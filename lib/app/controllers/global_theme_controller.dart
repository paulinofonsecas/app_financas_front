import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class GlobalThemeController extends GetxController {
  var isDarkMode = true;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    update();
  }
}
