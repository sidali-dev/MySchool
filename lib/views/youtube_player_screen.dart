import 'package:flutter/material.dart';
import 'package:myschool/controllers/youtube_player_controller.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerScreen extends StatelessWidget {
  final YoutubePlayerScreenController controller;

  const YoutubePlayerScreen({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: controller.youtubeController,
      builder: (context, player) => Scaffold(
        body: Column(
          children: [
            player,
            Text('Youtube Player'),
          ],
        ),
      ),
    );
  }
}
