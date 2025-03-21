class ApplyCouponResponse {
  ApplyCouponResponse({
    required this.message,
    required this.discount,
    required this.newTotal,
  });

  final String? message;
  final double discount;
  final int? newTotal;

  factory ApplyCouponResponse.fromJson(Map<String, dynamic> json) {
    return ApplyCouponResponse(
      message: json["message"],
      discount: double.tryParse(json["discount"].toString()) ??
          0.0, // Ensure conversion
      newTotal: json["new_total"],
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "discount": discount,
        "new_total": newTotal,
      };
}
