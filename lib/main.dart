import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myschool/my_app.dart';
import 'package:myschool/services/authentication_service.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:appwrite/appwrite.dart';

// import 'my_app.dart';

Future main() async {
  await dotenv.load();

  // WidgetsBinding binding =
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  Get.put(AuthenticationService());

  runApp(const MyApp());
}
