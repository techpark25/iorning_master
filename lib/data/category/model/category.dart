class Category {
    Category({
        required this.id,
        required this.name,
        required this.image,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final String? name;
    final String? image;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Category.fromJson(Map<String, dynamic> json){ 
        return Category(
            id: json["id"],
            name: json["name"],
            image: json["image"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };

}