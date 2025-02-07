import 'package:flutter/material.dart';

import '../../../data/product/model/sub_category.dart';

class CategoryButton extends StatelessWidget {
  final Subcategory subcategory;
  final bool isActive;
  final VoidCallback onTap;

  const CategoryButton({
    required this.isActive,
    required this.onTap,
    super.key, required this.subcategory,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
          gradient: isActive
              ? const LinearGradient(colors: [Color(0xFFFDC846), Color(0xFFD32943)])
              : null,
          color: !isActive ? Colors.grey[300] : null,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          subcategory.name ?? '',
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
