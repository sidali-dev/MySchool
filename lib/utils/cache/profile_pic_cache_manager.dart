import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ProfilePictureCacheManager extends CacheManager {
  static const key = 'profilePicsCache';

  ProfilePictureCacheManager()
      : super(
          Config(
            key,
            stalePeriod: const Duration(days: 7),
          ),
        );
}
