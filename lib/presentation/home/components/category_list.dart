import 'package:flutter/material.dart';
import 'package:laundry_application/data/product/model/sub_category.dart';
import 'package:laundry_application/themes.dart';

import '../../../data/category/model/menu.dart';
import '../../product/product_screen.dart';
import '../../../data/category/model/category.dart';

class CategoryList extends StatelessWidget {
  final List<Menu> categories;
  final List<Subcategory> subcategories;

  const CategoryList({
    super.key,
    required this.categories,
    required this.subcategories,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double catHeight = height * 0.14;

    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final category = categories[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: [
                // **Category Title (Left Side - 10% Width)**
                Expanded(
                  child: Container(
                    width: width * 0.1, // 10% of screen width
                    height: catHeight, // Match category height
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppThemes.primaryColor, // Background color
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: RotatedBox(
                      quarterTurns: 3, // Rotates text vertically
                      child: Text(
                        category.name ?? "",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8), // Space between title & grid

                // **Category Grid (Right Side - 90% Width)**
                Expanded(
                  flex: 13,
                  child: SizedBox(
                    height: catHeight, // Adjust height as needed
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 3 items per row
                        crossAxisSpacing: 12, // Horizontal spacing
                        mainAxisSpacing: 12, // Vertical spacing
                        childAspectRatio: 1, // Square items
                      ),
                      itemCount: category.categories.length,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemBuilder: (BuildContext context, int subIndex) {
                        final subCategory = category.categories[subIndex];

                        return GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductScreen(
                                title: subCategory.name,
                                categoryId: subCategory.id,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 246, 246, 246),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 224, 224, 224)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(17),
                                  child: Image.network(subCategory.image ?? ""),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Expanded(
                                child: Text(
                                  subCategory.name ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
