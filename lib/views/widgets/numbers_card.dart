import 'package:flutter/material.dart';

class NumbersCard extends StatelessWidget {
  const NumbersCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.imagePath,
    required this.onTap,
  });

  final double screenHeight;
  final double screenWidth;
  final String imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 50,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: screenWidth * 0.25,
          width: screenWidth * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(imagePath),
          ),
        ),
      ),
    );
  }
}
