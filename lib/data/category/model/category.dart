class Category {
  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.menuId,
  });

  final int? id;
  final String? name;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? menuId;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      menuId: json["menu_id"],
    );
  }
}
