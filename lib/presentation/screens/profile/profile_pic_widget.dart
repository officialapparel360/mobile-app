import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget(
      {super.key,
      required this.pickImage,
      this.imageFile,
      required this.networkImage});

  final VoidCallback pickImage;
  final File? imageFile;
  final String? networkImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Circle Avatar
        (networkImage?.isNotEmpty ?? false)
            ? SizedBox(
                height: 120.0,
                width: 120.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    imageUrl: networkImage!,
                  ),
                ),
              )
            : CircleAvatar(
                radius: 60,
                backgroundImage:
                    imageFile != null ? FileImage(imageFile!) : null,
                backgroundColor: Colors.grey[300],
              ),

        // Pencil Icon Positioned at bottom right
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: pickImage,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              padding: const EdgeInsets.all(6),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
