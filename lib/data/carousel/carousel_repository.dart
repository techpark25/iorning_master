import 'package:dio/dio.dart';

import '../../utils/api_status.dart';
import '../../utils/dio_wrapper.dart';
import 'carousel_list_response.dart';


class CarouselRepository {
  Future<ApiResponse<List<Carousel>>> getImage() async {
    try {
      final dio = await DioWrapper().getDio();
      Response response = await dio.get('/carousels');
      final sliderImagesResponse = CarouselListResponse.fromJson(response.data);
      return ApiResponse.success(sliderImagesResponse.data);
    } on DioError catch (e) {
      return ApiResponse.error(e, "Failed to get data");
    }
  }
}