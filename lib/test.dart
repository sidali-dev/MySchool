import 'package:flutter/material.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';
import 'package:myschool/utils/services/firebase_authentication.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await SHelperFunctions.checkInternetConnection(context);
              if (context.mounted) {
                FirebaseAuthentication.signUp(
                    email: "test@gmail.com",
                    password: "1112121212121",
                    context: context);
              }
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text("SIGN UP"),
            )),
      ),
    );
  }
}
