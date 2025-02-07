import 'package:dio/dio.dart';

import '../../utils/api_status.dart';
import '../../utils/dio_wrapper.dart';
import 'model/category.dart';
import 'model/category_response.dart';

class CategoryRepository {
  Future<ApiResponse<List<Category>>> getCategories() async {
    try {
      String url = '/categories';

      final dio = await DioWrapper().getDio();
      Response response = await dio.get(url);
      final categoryResponse = CategoryResponse.fromJson(response.data);
      return ApiResponse.success(categoryResponse.data);
    } on DioError catch (e) {
      return ApiResponse.error(e, "Failed to get data");
    }
  }
}