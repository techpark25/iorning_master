class Notification {
    Notification({
        required this.id,
        required this.userId,
        required this.content,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final int? userId;
    final String? content;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Notification.fromJson(Map<String, dynamic> json){ 
        return Notification(
            id: json["id"],
            userId: json["user_id"],
            content: json["content"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

}