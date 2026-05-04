import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioPlayerController extends GetxController {
  late AudioPlayer audioPlayer;
  late AudioSource audioSource;
  MediaItem? currentMediaItem;
  List<double> speeds = [1.0, 1.25, 1.5, 1.75, 2.0];
  int currentSpeedIndex = 0;

  /// Whether the current audio source is live radio (true) or podcast (false)
  final RxBool isLive = false.obs;

  /// Controls mini player visibility — user can hide on current page
  final RxBool isMiniPlayerVisible = true.obs;

  /// Tracks whether the player has an active media source
  final RxBool isPlayerActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    audioPlayer = AudioPlayer();
  }

  Future<void> setAudioSource(String url, MediaItem mediaItemTag) async {
    audioSource = AudioSource.uri(
      Uri.parse(url),
      tag: mediaItemTag,
    );

    currentMediaItem = mediaItemTag;
    // Defer reactive updates to avoid triggering Obx during build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isPlayerActive.value = true;
    });
    await audioPlayer.setAudioSource(audioSource);
  }

  Future<void> play() async {
    await audioPlayer.play();
  }

  Future<void> pause() async {
    await audioPlayer.pause();
  }

  Future<void> stop() async {
    await audioPlayer.stop();
  }

  /// Stop audio and completely hide the mini player globally
  Future<void> closeMiniPlayer() async {
    await audioPlayer.stop();
    isPlayerActive.value = false;
  }

  /// Hide mini player on the current page
  void hideMiniPlayer() => isMiniPlayerVisible.value = false;

  /// Show mini player (called on page navigation)
  void showMiniPlayer() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isMiniPlayerVisible.value = true;
    });
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
