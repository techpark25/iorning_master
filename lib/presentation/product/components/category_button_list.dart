import 'package:flutter/material.dart';

import '../../../data/product/model/sub_category.dart';
import 'category_button.dart';

class SubCategoriesList extends StatelessWidget {
  const SubCategoriesList({
    super.key,
    required this.categories,
    this.activeCategory,
    required this.onTap,
  });

  final List<Subcategory> categories;
  final int? activeCategory;
  final Function(Subcategory?) onTap;

  @override
  Widget build(BuildContext context) {
    final List<Subcategory> allCategories = [
      Subcategory(
        id: 0, // or null if you prefer
        image: "assets/img/all-category-icon.png",
        name: 'All',
        categoryId: null,
        categoryName: 'All Categories',
      ),
      ...categories,
    ];

    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: allCategories.length,
        itemBuilder: (BuildContext context, int index) {
          final category = allCategories[index];

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CategoryButton(
              subcategory: category,
              isActive: (activeCategory == null && category.id == 0) ||
                  (activeCategory == category.id),
              onTap: () {
                // Pass null for "All" selection
                if (category.id == 0) {
                  onTap(null); // This will send null to indicate "All"
                } else {
                  onTap(category); // Normal subcategory selection
                }
              },
            ),
          );
        },
      ),
    );
  }
}
