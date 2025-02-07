class Subcategory {
    Subcategory({
        required this.id,
        required this.name,
        required this.categoryId,
        required this.categoryName,
    });

    final int? id;
    final String? name;
    final int? categoryId;
    final String? categoryName;

    factory Subcategory.fromJson(Map<String, dynamic> json){ 
        return Subcategory(
            id: json["id"],
            name: json["name"],
            categoryId: json["category_id"],
            categoryName: json["category_name"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": categoryId,
        "category_name": categoryName,
    };

}