import 'address.dart';

class AddressCreateResponse {
    AddressCreateResponse({
        required this.message,
        required this.address,
    });

    final String? message;
    final Address? address;

    factory AddressCreateResponse.fromJson(Map<String, dynamic> json){ 
        return AddressCreateResponse(
            message: json["message"],
            address: json["address"] == null ? null : Address.fromJson(json["address"]),
        );
    }

}

