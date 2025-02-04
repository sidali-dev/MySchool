import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../models/asset_model.dart';
import '../utils/constants/get_keys.dart';

class YoutubePlayerScreenController extends GetxController {
  late YoutubePlayerController youtubeController;
  final Rx<AssetModel> assetModel;
  final RxList<AssetModel> otherVideos;
  final GetStorage box = GetStorage();
  final List<AssetModel> videosPlayed = [];
  late final ScrollController scrollController;
  late final CarouselSliderController carouselSliderController;

  YoutubePlayerScreenController({
    required this.assetModel,
    required this.otherVideos,
  });

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    carouselSliderController = CarouselSliderController();
    _initializePlayer();
  }

  void _initializePlayer() async {
    otherVideos.removeWhere((element) => element.id == assetModel.value.id);
    videosPlayed.add(assetModel.value);

    youtubeController = YoutubePlayerController(
      params: YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          color: "Red",
          pointerEvents: PointerEvents.auto,
          interfaceLanguage: box.read(GetKeys.selectedLanguage) ?? "en"),
    );
    await youtubeController.loadVideoById(
        videoId: parseVideoId(assetModel.value.fileLink)!);
  }

  Future playAnotherVideo(AssetModel newAssetModel) async {
    //Refreshes the list of "other videos"
    otherVideos.add(assetModel.value);
    otherVideos.removeWhere((element) => element.id == newAssetModel.id);

    //Adds the new video to the stack of played video
    videosPlayed.add(newAssetModel);

    //Assign the new asset
    assetModel.value = newAssetModel;

    //Play the new Asset
    await youtubeController.loadVideoById(
        videoId: parseVideoId(assetModel.value.fileLink)!);

    _scrollToTop();

    update();
  }

  Future playPreviousVideo() async {
    if (videosPlayed.length > 1) {
      //Refreshes the list of "other videos"
      otherVideos.add(assetModel.value);
      otherVideos.removeWhere((element) => element.id == videosPlayed.last.id);

      //Removes the video from the stack of played video
      videosPlayed.removeLast();

      //Assign the new asset
      assetModel.value = videosPlayed.last;

      //Play the new Asset
      await youtubeController.loadVideoById(
          videoId: parseVideoId(assetModel.value.fileLink)!);
      _scrollToTop();
    }
    if (videosPlayed.length == 2) {}
    update();
  }

  String? parseVideoId(String url) {
    final regex = RegExp(
      r'^.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/|shorts\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*',
      caseSensitive: false,
    );
    final match = regex.firstMatch(url);
    return (match != null && match.group(1)!.length == 11)
        ? match.group(1)
        : null;
  }

  void _scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    carouselSliderController.animateToPage(0, curve: Curves.easeIn);
  }

  @override
  void onClose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    youtubeController.close();
    scrollController.dispose();
    super.onClose();
  }
}
