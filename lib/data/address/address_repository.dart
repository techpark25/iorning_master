import 'package:dio/dio.dart';
import 'package:laundry_application/data/address/data/address_create_response.dart';
import 'package:laundry_application/data/address/data/address_list_response.dart';

import '../../utils/api_status.dart';
import '../../utils/dio_wrapper.dart';
import 'data/address.dart';
import 'data/address_edit_response.dart';
import 'data/address_status_response.dart';

class AddressRepository {
  Future<ApiResponse<List<Address>>> getAddress() async {
    try {
      String url = '/addresses';

      final dio = await DioWrapper().getDio();
      Response response = await dio.get(url);
      final addressListResponse = AddressListResponse.fromJson(response.data);
      return ApiResponse.success(addressListResponse.addresses);
    } on DioError catch (e) {
      return ApiResponse.error(e, "Failed to get data");
    }
  }

  Future<ApiResponse<AddressCreateResponse?>> createAddress(
      {String? name,
      String? houseNo,
      String? addressLine1,
      String? addressLine2,
      String? landmark,
      bool? status,
      String? latitude,
      String? longitude,
      String? pincode}) async {
    final reqData = {
      "name": name,
      "house_or_building_no": houseNo,
      "address_line_1": addressLine1,
      "address_line_2": addressLine2,
      "landmark": landmark,
      "active_status": status,
      "latitude": latitude,
      "longitude": longitude,
      "pincode": pincode,
    };

    try {
      final dio = await DioWrapper().getDio();
      Response response = await dio.post('/addresses/create', data: reqData);
      final addressCreateResponse =
          AddressCreateResponse.fromJson(response.data);

      return ApiResponse.success(addressCreateResponse);
    } on DioException catch (e) {
      return ApiResponse.error(e, "Failed to create order");
    }
  }

  Future<ApiResponse<AddressEditResponse?>> editAddress(
     int? addressId,
      {String? name,
      String? houseNo,
      String? addressLine1,
      String? addressLine2,
      String? landmark,
      bool? status,
      String? latitude,
      String? longitude,
      String? pincode}) async {
    final reqData = {
      "name": name,
      "house_or_building_no": houseNo,
      "address_line_1": addressLine1,
      "address_line_2": addressLine2,
      "landmark": landmark,
      "active_status": status,
      "latitude": latitude,
      "longitude": longitude,
      "pincode": pincode,
    };

    try {
      final dio = await DioWrapper().getDio();
      Response response = await dio.post('/address/edit/$addressId', data: reqData);
      final addressEditResponse = AddressEditResponse.fromJson(response.data);

      return ApiResponse.success(addressEditResponse);
    } on DioException catch (e) {
      return ApiResponse.error(e, "Failed to create order");
    }
  }
  Future<ApiResponse<AddressStatusResponse?>> updateStatus(
     int? addressId) async {
    

    try {
      final dio = await DioWrapper().getDio();
      Response response = await dio.post('/addresses/$addressId/set-active');
      final addressStatusResponse = AddressStatusResponse.fromJson(response.data);

      return ApiResponse.success(addressStatusResponse);
    } on DioException catch (e) {
      return ApiResponse.error(e, "Failed to create order");
    }
  }
}
