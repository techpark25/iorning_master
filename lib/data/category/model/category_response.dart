import 'category.dart';

class CategoryResponse {
    CategoryResponse({
        required this.message,
        required this.data,
    });

    final String? message;
    final List<Category> data;

    factory CategoryResponse.fromJson(Map<String, dynamic> json){ 
        return CategoryResponse(
            message: json["message"],
            data: json["data"] == null ? [] : List<Category>.from(json["data"]!.map((x) => Category.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.map((x) => x.toJson()).toList(),
    };

}


