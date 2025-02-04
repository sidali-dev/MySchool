import 'package:flutter/material.dart';

class YouTubeThumbnail extends StatelessWidget {
  final String videoId;

  const YouTubeThumbnail({super.key, required this.videoId});

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
            : const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) {
        // Fallback to a lower resolution if the first fails
        final fallbackUrl = 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
        return Image.network(
          fallbackUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Ultimate fallback to an error icon
            return const Center(child: Icon(Icons.error, color: Colors.red));
          },
        );
      },
    );
  }
}
