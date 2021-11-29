import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rabble/services/audio_service/audio_enum.dart';

class StateController extends GetxController {
  StateController();

  ButtonState isPlaying = ButtonState.paused;
  PersistentTabController controller = PersistentTabController(initialIndex: 0);
}
