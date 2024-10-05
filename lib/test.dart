import 'package:flutter/material.dart';
import 'package:myschool/utils/services/appwrite_provider.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("HOME"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await AppwriteProvider().signOut(context);
        },
      ),
    );
  }
}
