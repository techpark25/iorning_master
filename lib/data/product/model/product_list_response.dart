import 'product.dart';
import 'sub_category.dart';

class ProductListResponse {
    ProductListResponse({
        required this.code,
        required this.message,
        required this.data,
    });

    final int? code;
    final String? message;
    final ProductByCategoryData? data;

    factory ProductListResponse.fromJson(Map<String, dynamic> json){ 
        return ProductListResponse(
            code: json["code"],
            message: json["message"],
            data: json["data"] == null ? null : ProductByCategoryData.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
    };

}

class ProductByCategoryData {
    ProductByCategoryData({
        required this.activeCategory,
        required this.subcategories,
        required this.products,
    });

    final int? activeCategory;
    final List<Subcategory> subcategories;
    final List<Product> products;

    factory ProductByCategoryData.fromJson(Map<String, dynamic> json){ 
        return ProductByCategoryData(
            activeCategory: json["active_category"],
            subcategories: json["subcategories"] == null ? [] : List<Subcategory>.from(json["subcategories"]!.map((x) => Subcategory.fromJson(x))),
            products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "active_category": activeCategory,
        "subcategories": subcategories.map((x) => x?.toJson()).toList(),
        "products": products.map((x) => x?.toJson()).toList(),
    };

}




