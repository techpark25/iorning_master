import 'package:dio/dio.dart';

import '../../utils/api_status.dart';
import '../../utils/dio_wrapper.dart';
import 'model/category.dart';
import 'model/category_response.dart';
import 'model/menu.dart';

class CategoryRepository {
  Future<ApiResponse<List<Menu>>> getCategories() async {
    try {
      String url = '/categories'; // Update with actual API endpoint

      final dio = await DioWrapper().getDio();
      Response response = await dio.get(url);
      final menuResponse = CategoryResponse.fromJson(response.data);
      return ApiResponse.success(menuResponse.data);
    } on DioException catch (e) {
      return ApiResponse.error(e, "Failed to get data");
    }
  }
}
