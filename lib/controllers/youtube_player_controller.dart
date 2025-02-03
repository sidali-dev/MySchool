import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../utils/constants/get_keys.dart';

class YoutubePlayerScreenController extends GetxController {
  late YoutubePlayerController youtubeController;
  final String videoId;
  final GetStorage box = GetStorage();

  YoutubePlayerScreenController(this.videoId);

  @override
  void onInit() {
    super.onInit();
    _initializePlayer();
  }

  void _initializePlayer() {
    youtubeController = YoutubePlayerController(
      params: YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          color: "Red",
          interfaceLanguage: box.read(GetKeys.selectedLanguage) ?? "en"),
    );
    youtubeController.loadVideoById(videoId: videoId);
  }

  @override
  void onClose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    youtubeController.close();
    super.onClose();
  }
}
