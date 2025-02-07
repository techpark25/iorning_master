import 'address.dart';

class AddressEditResponse {
    AddressEditResponse({
        required this.message,
        required this.address,
    });

    final String? message;
    final Address? address;

    factory AddressEditResponse.fromJson(Map<String, dynamic> json){ 
        return AddressEditResponse(
            message: json["message"],
            address: json["address"] == null ? null : Address.fromJson(json["address"]),
        );
    }

}

