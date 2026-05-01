import 'package:get/get.dart';

import 'audio_player_controller.dart';

class NavBarController extends GetxController {
  var tabIndex = 0;
  void changeTabIndex(int index) {
    tabIndex = index;
    // Re-show mini player when switching tabs (option A behavior) if player is active
    if (Get.isRegistered<AudioPlayerController>()) {
      final controller = Get.find<AudioPlayerController>();
      if (controller.isPlayerActive.value) {
        controller.showMiniPlayer();
      }
    }
    update();
  }
}