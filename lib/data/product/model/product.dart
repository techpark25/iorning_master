class Product {
    Product({
        required this.id,
        required this.name,
        required this.description,
        required this.price,
        required this.image,
        required this.subcategoryId,
    });

    final int? id;
    final String? name;
    final dynamic description;
    final String? price;
    final String? image;
    final int? subcategoryId;

    factory Product.fromJson(Map<String, dynamic> json){ 
        return Product(
            id: json["id"],
            name: json["name"],
            description: json["description"],
            price: json["price"],
            image: json["image"],
            subcategoryId: json["subcategory_id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "image": image,
        "subcategory_id": subcategoryId,
    };

}