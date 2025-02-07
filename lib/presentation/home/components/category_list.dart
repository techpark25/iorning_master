import 'package:flutter/material.dart';
import 'package:laundry_application/data/product/model/sub_category.dart';

import '../../product/product_screen.dart';
import '../../../data/category/model/category.dart';
import 'category_card.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  final List<Subcategory> subcategories;

  const CategoryList({super.key, required this.categories, required this.subcategories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Adjust height as needed for your UI
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final category = categories[index];
          // Ensure that the category has subcategories and pass the first one
         

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CategoryCard(
              serviceName: category.name ?? '',
              backgroundImageUrl: category.image,
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductScreen(
                  title: category.name,
                  categoryId: category.id == 0 ? null : category.id, // Null means show all
                ),
              )),
            ),
          );
        },
      ),
    );
  }
}
