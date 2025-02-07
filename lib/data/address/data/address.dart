class Address {
  Address({
    required this.id,
    required this.userId,
    required this.houseOrBuildingNo,
    required this.addressLine1,
    required this.pincode,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.addressLine2,
    required this.landmark,
    this.activeStatus = 0, // Default inactive
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? userId;
  final String? houseOrBuildingNo;
  final String? addressLine1;
  final String? pincode;
  final String? name;
  final String? latitude;
  final String? longitude;
  final String? addressLine2;
  final String? landmark;
  int activeStatus; // Make this non-final to allow modifications
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Method to update activeStatus
  void updateActiveStatus(int newStatus) {
    activeStatus = newStatus;
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json["id"],
      userId: json["user_id"],
      houseOrBuildingNo: json["house_or_building_no"],
      addressLine1: json["address_line_1"],
      pincode: json["pincode"],
      name: json["name"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      addressLine2: json["address_line_2"],
      landmark: json["landmark"],
      activeStatus: json["active_status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
