import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:appwrite/appwrite.dart';

import 'my_app.dart';

Future main() async {
  await dotenv.load();

  // WidgetsBinding binding =
  WidgetsFlutterBinding.ensureInitialized();

  // await Supabase.initialize(
  //     url: dotenv.get("SUPABASE_URL"),
  //     anonKey: dotenv.get("SUPABASE_ANNON_KEY"),
  //     debug: true,
  //     authOptions:
  //         const FlutterAuthClientOptions(authFlowType: AuthFlowType.pkce),
  //     storageOptions: const StorageClientOptions(retryAttempts: 10));
  runApp(MyApp());
}
