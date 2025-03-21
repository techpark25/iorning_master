import 'package:dio/dio.dart';

import 'model/product_list_response.dart';
import '../../utils/api_status.dart';
import '../../utils/dio_wrapper.dart';

class ProductRepository {
  Future<ApiResponse<ProductByCategoryData>> getProducts(
    int? categoryId,
    int? subcategoryId,
  ) async {
    try {
      String url = '/subcategories?category_id=$categoryId';
      
      if (subcategoryId != null && subcategoryId != 0) {
        url += '&subcategory_id=$subcategoryId';
      }

      final dio = await DioWrapper().getDio();
      Response response = await dio.get(url);
      final productListResponse = ProductListResponse.fromJson(response.data);
      return ApiResponse.success(productListResponse.data);
    } on DioError catch (e) {
      return ApiResponse.error(e, "Failed to get data");
    }
  }
}


