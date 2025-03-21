import 'coupon.dart';

class CouponListResponse {
    CouponListResponse({
        required this.status,
        required this.message,
        required this.coupons,
    });

    final bool? status;
    final String? message;
    final List<Coupon> coupons;

    factory CouponListResponse.fromJson(Map<String, dynamic> json){ 
        return CouponListResponse(
            status: json["status"],
            message: json["message"],
            coupons: json["coupons"] == null ? [] : List<Coupon>.from(json["coupons"]!.map((x) => Coupon.fromJson(x))),
        );
    }

}


