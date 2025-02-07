import 'address.dart';

class AddressStatusResponse {
    AddressStatusResponse({
        required this.message,
        required this.address,
    });

    final String? message;
    final Address? address;

    factory AddressStatusResponse.fromJson(Map<String, dynamic> json){ 
        return AddressStatusResponse(
            message: json["message"],
            address: json["address"] == null ? null : Address.fromJson(json["address"]),
        );
    }

}

