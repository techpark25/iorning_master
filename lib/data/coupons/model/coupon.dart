class Coupon {
    Coupon({
        required this.id,
        required this.code,
        required this.discountAmount,
        required this.discountType,
        required this.minCartAmount,
        required this.validFrom,
        required this.validUntil,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final String? code;
    final String? discountAmount;
    final String? discountType;
    final String? minCartAmount;
    final DateTime? validFrom;
    final DateTime? validUntil;
    final bool? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Coupon.fromJson(Map<String, dynamic> json){ 
        return Coupon(
            id: json["id"],
            code: json["code"],
            discountAmount: json["discount_amount"],
            discountType: json["discount_type"],
            minCartAmount: json["min_cart_amount"],
            validFrom: DateTime.tryParse(json["valid_from"] ?? ""),
            validUntil: DateTime.tryParse(json["valid_until"] ?? ""),
      status: json["status"] == 1, // ✅ Convert int (1 or 0) to bool (true/false)
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

}