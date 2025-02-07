import 'address.dart';

class AddressListResponse {
    AddressListResponse({
        required this.addresses,
    });

    final List<Address> addresses;

    factory AddressListResponse.fromJson(Map<String, dynamic> json){ 
        return AddressListResponse(
            addresses: json["addresses"] == null ? [] : List<Address>.from(json["addresses"]!.map((x) => Address.fromJson(x))),
        );
    }

}

