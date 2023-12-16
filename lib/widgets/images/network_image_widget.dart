import 'package:flutter/material.dart';

class ImageNetworkWidget extends StatelessWidget {
  const ImageNetworkWidget({
    super.key,
    required this.imagePath,
    this.height = 150,
  });
  final String imagePath;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.network(imagePath,
        loadingBuilder: (context, child, loadingProgress) {
      return loadingProgress == null
          ? child
          : SizedBox(
              height: height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
    }, frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
      return child;
    }, width: double.infinity, height: height, fit: BoxFit.cover);
  }
}
