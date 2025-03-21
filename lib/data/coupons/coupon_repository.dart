import 'package:dio/dio.dart';

import '../../utils/api_status.dart';
import '../../utils/dio_wrapper.dart';
import 'model/coupon.dart';
import 'model/coupon_list_response.dart';
import 'model/coupon_response.dart';

class CouponRepository {
  Future<ApiResponse<List<Coupon>>> getCoupons() async {
    try {
      String url = '/coupons';

      final dio = await DioWrapper().getDio();
      Response response = await dio.get(url);
      final ordersResponse = CouponListResponse.fromJson(response.data);
      return ApiResponse.success(ordersResponse.coupons);
    } on DioError catch (e) {
      return ApiResponse.error(e, "Failed to get data");
    }
  }

  Future<ApiResponse<ApplyCouponResponse?>> applyCoupon({
    required String couponCode,
    required double cartTotal,
  }) async {
    final reqData = {
      "coupon_code": couponCode,
      "cart_total": cartTotal,
    };

    try {
      final dio = await DioWrapper().getDio();
      Response response = await dio.post('/apply-coupon', data: reqData);
      final couponResponse = ApplyCouponResponse.fromJson(response.data);

      return ApiResponse.success(couponResponse);
    } on DioException catch (e) {
      return ApiResponse.error(e, "Failed to apply coupon");
    }
  }
}
