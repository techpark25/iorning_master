import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../data/coupons/coupon_repository.dart';
import '../../../data/coupons/model/coupon.dart';
import '../../../data/coupons/model/coupon_response.dart';
import '../../../utils/api_status.dart';

class CouponViewModel extends ChangeNotifier {
  final CouponRepository repository = CouponRepository();
  ApiResponse<ApplyCouponResponse?> couponResponse = ApiResponse.idle();

  ApiResponse<List<Coupon>> _categoriesResponse = ApiResponse.idle();
  bool _showOrders = false;
  bool _lodingOrders = false;
  List<Coupon> _coupons = [];
  String errorMessage = "";

  bool get showOrders => _showOrders;
  bool get loadingOrders => _lodingOrders;
  List<Coupon> get coupons => _coupons;

  ApplyCouponResponse? data;

  Future getCoupons() async {
    // if (_carouselImagesResponse.status == ApiStatus.success) return;

    _notifyCategoriesLoading();
    _categoriesResponse = await repository.getCoupons();
    _notifyCategoriesResponse();
  }

  void _notifyCategoriesLoading() {
    _categoriesResponse = ApiResponse.loading('');
    _showOrders = true;
    _lodingOrders = true;
    notifyListeners();
  }

  void _notifyCategoriesResponse() {
    _lodingOrders = false;
    if (_categoriesResponse.status == ApiStatus.success) {
      final coupons = _categoriesResponse.data;
      if (_categoriesResponse.status == ApiStatus.error ||
          coupons == null ||
          coupons.isEmpty) {
        _showOrders = false;
      } else {
        _coupons = coupons;
      }
    }
    notifyListeners();
  }

  Future<void> applyCoupon({
    required String couponCode,
    required double cartTotal,
  }) async {
    couponResponse = ApiResponse.loading('Applying Coupon...');
    notifyListeners();

    try {
      couponResponse = await repository.applyCoupon(
        couponCode: couponCode,
        cartTotal: cartTotal,
      );

      if (couponResponse.status == ApiStatus.success) {
        data = couponResponse.data;
      } else if (couponResponse.status == ApiStatus.error) {
        final e = couponResponse.exception;
        if (e is DioException) {
          if (e.response?.statusCode == 400) {
            errorMessage = "Invalid coupon or does not meet the criteria.";
          } else if (e.response?.statusCode == 404) {
            errorMessage = "Coupon not found.";
          } 
        }
      }
    } finally {
      notifyListeners();
    }
  }
}
