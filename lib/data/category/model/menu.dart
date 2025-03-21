import 'package:flutter/src/widgets/icon_data.dart';

import 'category.dart';

class Menu {
  Menu({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.categories,
  });

  final int? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Category> categories;

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json["id"],
      name: json["name"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      categories: json["categories"] == null
          ? []
          : List<Category>.from(
              json["categories"]!.map((x) => Category.fromJson(x))),
    );
  }

  IconData? get icon => null;
}
