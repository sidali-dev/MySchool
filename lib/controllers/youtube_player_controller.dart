import 'package:get/get.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerScreenController extends GetxController {
  late YoutubePlayerController youtubeController;
  final String videoId;

  YoutubePlayerScreenController(this.videoId);

  @override
  void onInit() {
    super.onInit();
    _initializePlayer();
  }

  void _initializePlayer() {
    youtubeController = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    youtubeController.loadVideoById(videoId: videoId);
  }

  @override
  void onClose() {
    youtubeController.close();
    super.onClose();
  }
}
