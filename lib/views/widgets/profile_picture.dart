import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:myschool/services/database_service.dart';
import 'package:myschool/views/widgets/spinning_logo.dart';
import '../../utils/cache/profile_pic_cache_manager.dart';

class ProfilePicture extends StatelessWidget {
  ProfilePicture({
    required this.profilePic,
    required this.screenWidth,
    super.key,
  });
  final String? profilePic;
  final double screenWidth;

  final ProfilePictureCacheManager _cacheManager = ProfilePictureCacheManager();

  @override
  Widget build(BuildContext context) {
    // If profilePic is null or empty, show the fallback avatar
    if (profilePic == null) {
      return _buildFallbackAvatar();
    }
    if (profilePic!.isEmpty) {
      return _buildFallbackAvatar();
    }

    // If profilePic exists, fetch and display the image
    final diameter = screenWidth / 3;
    return FutureBuilder<File>(
      future: _getCachedImage(profilePic!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return InkWell(
            onTap: () => showDialog(
              context: context,
              builder: (context) => Center(
                child: Animate(
                  effects: const [FlipEffect(begin: 1.5, end: 2.0)],
                  child: ClipOval(
                    child: Image.file(
                      snapshot.data!,
                      width: diameter * 2,
                      height: diameter * 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            child: CircleAvatar(
              radius: screenWidth / 6,
              backgroundColor: Colors.lightBlue.shade100,
              child: ClipOval(
                child: Image.file(
                  snapshot.data!,
                  width: diameter,
                  height: diameter,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return _buildFallbackAvatar();
        }
        return _buildLoadingAvatar();
      },
    );
  }

  Future<File> _getCachedImage(String fileId) async {
    // Generate a unique cache key for the file
    final cacheKey = 'profilePic_$fileId';

    // Check if the file is already cached
    final cachedFile = await _cacheManager.getFileFromCache(cacheKey);
    if (cachedFile != null) {
      return cachedFile.file;
    }

    // If not cached, fetch the image from Appwrite
    DatabaseService databaseService = DatabaseService();
    final Uint8List imageBytes =
        await databaseService.getImageLink(fileId: fileId);

    // Cache the image
    return await _cacheManager.putFile(
      cacheKey,
      imageBytes,
      fileExtension: 'jpg',
    );
  }

  Widget _buildFallbackAvatar() {
    return CircleAvatar(
      backgroundColor: Colors.lightBlue.shade100,
      radius: screenWidth / 6,
      child: Icon(
        Icons.person,
        color: Colors.blue,
        size: screenWidth / 4,
      ),
    );
  }

  Widget _buildLoadingAvatar() {
    return CircleAvatar(
      radius: screenWidth / 6,
      backgroundColor: Colors.lightBlue.shade100,
      child: const SpinningLogo(),
    );
  }
}
