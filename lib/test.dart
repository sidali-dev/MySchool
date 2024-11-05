import 'package:flutter/material.dart';

import 'controllers/sign_in_controller.dart';

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
          await SignInController().signOut(context: context);
        },
      ),
    );
  }
}
