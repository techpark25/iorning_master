import 'package:dio/dio.dart';

import 'model/cart_list_response.dart';
import 'model/cart_add_response.dart';
import 'model/cart_remove_response.dart';
import '../../utils/api_status.dart';
import '../../utils/dio_wrapper.dart';

class CartRepository {
  Future<ApiResponse<CartListResponse>> getCart() async {
    try {
      String url = '/cart';

      final dio = await DioWrapper().getDio();
      Response response = await dio.get(url);
      final cartResponse = CartListResponse.fromJson(response.data);
      return ApiResponse.success(cartResponse);
    } on DioError catch (e) {
      return ApiResponse.error(e, "Failed to get cart data");
    }
  }

  /// Add a product to the cart
  Future<ApiResponse<CartAddResponse>> addToCart(int productId) async {
    try {
      String url = '/cart/add';

      final dio = await DioWrapper().getDio();
      Response response = await dio.post(
        url,
        data: {
          "product_id": productId,
        },
      );

      final addResponse = CartAddResponse.fromJson(response.data);
      return ApiResponse.success(addResponse);
    } on DioError catch (e) {
      return ApiResponse.error(e, "Failed to add product to cart");
    }
  }

  /// Remove a product from the cart
  Future<ApiResponse<CartRemoveResponse>> removeFromCart(int cartItemId) async {
    try {
      String url = '/cart/$cartItemId/remove';

      final dio = await DioWrapper().getDio();
      Response response = await dio.delete(url);

      final removeResponse = CartRemoveResponse.fromJson(response.data);
      return ApiResponse.success(removeResponse);
    } on DioError catch (e) {
      return ApiResponse.error(e, "Failed to remove product from cart");
    }
  }

  Future<ApiResponse<CartRemoveResponse>> clearCart() async {
    try {
      String url = '/cart/clear';

      final dio = await DioWrapper().getDio();
      Response response = await dio.delete(url);

      final removeResponse = CartRemoveResponse.fromJson(response.data);
      return ApiResponse.success(removeResponse);
    } on DioError catch (e) {
      return ApiResponse.error(e, "Failed to remove product from cart");
    }
  }
}
