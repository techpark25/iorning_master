class CartAddResponse {
    CartAddResponse({
        required this.message,
        required this.cartItem,
    });

    final String? message;
    final CartItem? cartItem;

    factory CartAddResponse.fromJson(Map<String, dynamic> json){ 
        return CartAddResponse(
            message: json["message"],
            cartItem: json["cart_item"] == null ? null : CartItem.fromJson(json["cart_item"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "message": message,
        "cart_item": cartItem?.toJson(),
    };

}

class CartItem {
    CartItem({
        required this.id,
        required this.userId,
        required this.productId,
        required this.quantity,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final int? userId;
    final int? productId;
    final int? quantity;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory CartItem.fromJson(Map<String, dynamic> json){ 
        return CartItem(
            id: json["id"],
            userId: json["user_id"],
            productId: json["product_id"],
            quantity: json["quantity"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "quantity": quantity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };

}
