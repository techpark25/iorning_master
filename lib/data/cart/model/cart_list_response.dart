import '../../product/model/product.dart';

class CartListResponse {
  CartListResponse({
    required this.data,
    required this.totalPrice,
    required this.totalQuantity,
  });

  final List<Cart> data;
  final int? totalPrice;
  final int? totalQuantity;

  factory CartListResponse.fromJson(Map<String, dynamic> json) {
    return CartListResponse(
      data: json["data"] == null
          ? []
          : List<Cart>.from(json["data"]!.map((x) => Cart.fromJson(x))),
      totalPrice: json["total_price"],
      totalQuantity: json["total_quantity"],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x?.toJson()).toList(),
        "total_price": totalPrice,
        "total_quantity": totalQuantity,
      };
}

class Cart {
  Cart({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  final int? id;
  final int? userId;
  final int? productId;
  int? quantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json["id"],
      userId: json["user_id"],
      productId: json["product_id"],
      quantity: json["quantity"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      product:
          json["product"] == null ? null : Product.fromJson(json["product"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "quantity": quantity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product?.toJson(),
      };
}
