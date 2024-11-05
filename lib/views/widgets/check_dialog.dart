import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myschool/utils/device/device_utility.dart';

class CheckDialog extends StatefulWidget {
  final String title;
  final String imagePath;
  final Color color;

  const CheckDialog({
    super.key,
    required this.title,
    required this.imagePath,
    required this.color,
  });

  @override
  State<CheckDialog> createState() => _CheckDialogState();
}

class _CheckDialogState extends State<CheckDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _lottieController;

  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(vsync: this);
    _lottieController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        _lottieController.reset();
      }
    });
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      // elevation: 35,
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Lottie.asset(
                height: SDeviceUtils.getScreenHeight(context) * 0.22,
                fit: BoxFit.contain,
                widget.imagePath,
                repeat: false,
                controller: _lottieController,
                onLoaded: (p0) {
                  _lottieController.duration = p0.duration;
                  _lottieController.forward();
                },
              ),
              const SizedBox(height: 20),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: widget.color,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
