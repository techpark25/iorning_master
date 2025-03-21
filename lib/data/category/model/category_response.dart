import 'menu.dart';

class CategoryResponse {
  CategoryResponse({
    required this.message,
    required this.data,
  });

  final String? message;
  final List<Menu> data;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<Menu>.from(json["data"]!.map((x) => Menu.fromJson(x))),
    );
  }
}
