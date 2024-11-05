import 'package:flutter/material.dart';

class InternetAvailability extends StatelessWidget {
  const InternetAvailability({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "NO INTERNET CONNECTION",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
