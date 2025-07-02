import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullScreenImageWidget extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    var screenSize=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Close on tap
        },
        child: Center(
          child: InteractiveViewer(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: screenSize.height,
              errorWidget: (context, error, stackTrace) => Image.asset(
                'assets/images/placeholder.jpg',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
