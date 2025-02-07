class CarouselListResponse {
    CarouselListResponse({
        required this.status,
        required this.data,
    });

    final String? status;
    final List<Carousel> data;

    factory CarouselListResponse.fromJson(Map<String, dynamic> json){ 
        return CarouselListResponse(
            status: json["status"],
            data: json["data"] == null ? [] : List<Carousel>.from(json["data"]!.map((x) => Carousel.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.map((x) => x?.toJson()).toList(),
    };

}

class Carousel {
    Carousel({
        required this.id,
        required this.imagePath,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final String? imagePath;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Carousel.fromJson(Map<String, dynamic> json){ 
        return Carousel(
            id: json["id"],
            imagePath: json["image_path"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "image_path": imagePath,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };

}
