class Subcategory {
  Subcategory({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.categoryName,
    required this.image,
  });

  final int? id;
  final String? name;
  final int? categoryId;
  final String? categoryName;
  final String? image;

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json["id"],
      name: json["name"],
      categoryId: json["category_id"],
      categoryName: json["category_name"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": categoryId,
        "category_name": categoryName,
        "image": image,
      };
}
