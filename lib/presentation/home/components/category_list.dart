import 'package:flutter/material.dart';
import 'package:laundry_application/data/product/model/sub_category.dart';
import 'package:laundry_application/themes.dart';
import '../../../data/category/model/menu.dart';
import '../../product/product_screen.dart';

class CategoryList extends StatefulWidget {
  final List<Menu> categories;

  const CategoryList({super.key, required this.categories});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double catHeight = height * 0.14;

    // ✅ Handle case when categories list is empty
    if (widget.categories.isEmpty) {
      return const Center(
        child: Text(
          "No categories available",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }

    final Menu selectedCategory = widget.categories[selectedCategoryIndex];

    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: Opacity(
            opacity: 0.8, // Adjust opacity (0.0 to 1.0)
            child: Image.asset(
              "assets/img/category-bg.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: [
            const SizedBox(height: 20), // Add padding at the top
            // *Category Selection List*
            SizedBox(
              height: 40, // Adjust height as needed
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.categories.length, (index) {
                      final category = widget.categories[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategoryIndex = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: selectedCategoryIndex == index
                                ? AppThemes.primaryColor
                                : const Color.fromARGB(255, 247, 241, 255),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            category.name ?? "",
                            style: TextStyle(
                              fontSize: 13,
                              color: selectedCategoryIndex == index
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // *Subcategory Grid*
            if (selectedCategory.categories.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "No subcategories available",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              )
            else
              SizedBox(
                height: catHeight,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 2,
                    childAspectRatio: 1,
                  ),
                  itemCount: selectedCategory.categories.length,
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  itemBuilder: (BuildContext context, int subIndex) {
                    final subCategory = selectedCategory.categories[subIndex];

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
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color.fromARGB(255, 217, 194, 255),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(17),
                              child: subCategory.image != null &&
                                      subCategory.image!.isNotEmpty
                                  ? Image.network(subCategory.image!)
                                  : const Icon(Icons.image,
                                      size: 40, color: Colors.grey),
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
          ],
        ),
      ],
    );
  }
}
