import 'package:flutter/material.dart';

class AppHelper {
  void showFullScreenLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      },
      barrierColor: Colors.black.withOpacity(0.5), // dim background
    );
  }
}
