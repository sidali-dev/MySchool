import 'package:flutter/material.dart';

class YouTubeThumbnail extends StatelessWidget {
  final String videoId;
  final bool isDark;

  const YouTubeThumbnail(
      {super.key, required this.videoId, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final thumbnailUrl =
        "https://img.youtube.com/vi/$videoId/maxresdefault.jpg";

    return Image.network(
      thumbnailUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        return progress == null
            ? child
            : const SizedBox(
                width: 200,
                height: 120,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
      },
      errorBuilder: (context, error, stackTrace) {
        // Fallback to a lower resolution if the first fails
        final fallbackUrl = 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
        return Image.network(
          fallbackUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Ultimate fallback to an error icon
            return Container(
              width: 200,
              height: 120,
              decoration: const BoxDecoration(color: Colors.grey),
              child: Center(
                child: Icon(
                  Icons.videocam_off_outlined,
                  color: isDark ? Colors.black : Colors.white,
                  size: 64,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
