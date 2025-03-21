import 'package:flutter/material.dart';
import 'package:laundry_application/themes.dart';

import '../../../data/product/model/sub_category.dart';

class CategoryButton extends StatelessWidget {
  final Subcategory subcategory;
  final bool isActive;
  final VoidCallback onTap;

  const CategoryButton({
    required this.isActive,
    required this.onTap,
    super.key,
    required this.subcategory,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        height: 50, // Set a fixed height
        decoration: BoxDecoration(
          color: !isActive ? Colors.grey[300] : AppThemes.primaryColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        alignment: Alignment.center, // Align text to center vertically
        child: Row(
          children: [
            // Apply color filter only when active
            ColorFiltered(
              colorFilter: isActive
                  ? const ColorFilter.mode(
                      Colors.white, BlendMode.srcATop) // Change active color
                  : const ColorFilter.mode(
                      Colors.transparent, BlendMode.srcATop), // Default
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: subcategory.id == 0
                        ? const AssetImage(
                            'assets/img/all-category-icon.png') // Asset for "All"
                        : NetworkImage(subcategory.image ?? '')
                            as ImageProvider, // Network for others
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              subcategory.name ?? '',
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
