import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String serviceName;
  final String? backgroundImageUrl;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.serviceName,
    this.backgroundImageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: backgroundImageUrl != null
              ? DecorationImage(
                  image: CachedNetworkImageProvider(
                      maxWidth: 250, maxHeight: 90, backgroundImageUrl!),
                  fit: BoxFit.cover,
                )
              : null, // No image if URL is null
          color:
              backgroundImageUrl == null ? Colors.grey : null, // Fallback color
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.iron_sharp, // Default icon
                color: Colors.white,
                size: 25.0,
              ),
              const SizedBox(height: 10),
              Text(
                serviceName,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
