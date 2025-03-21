import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  final String? imageUrl;

  const CarouselImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ??
          'https://via.placeholder.com/800x400?text=No+Image', // Fallback image
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: Colors.black12, // Light background while loading
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey.shade300,
        child:
            const Icon(Icons.broken_image, size: 50, color: Colors.redAccent),
      ),
    );
  }
}
