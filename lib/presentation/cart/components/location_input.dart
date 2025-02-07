import 'package:flutter/material.dart';

import '../../../data/address/data/address.dart';

class LocationInput extends StatelessWidget {
  final TextEditingController controller;
  final Address? address; // The address object
  final bool activeStatus; // To check if the address should be shown

  const LocationInput({
    Key? key,
    required this.controller,
    this.address,
    required this.activeStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If activeStatus is true and address is available, show it
    if (activeStatus && address != null) {
      final fullAddress = _getFullAddress(address!);
      controller.text = fullAddress;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Add Location",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: activeStatus && address != null
                ? 'Address: $address'
                : 'Enter your location',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }

  // Helper method to concatenate address fields
  String _getFullAddress(Address address) {
    String fullAddress = '';

    // Concatenate all address components
    if (address.name != null) fullAddress += address.name!;

    if (address.houseOrBuildingNo != null)
      fullAddress += ', ${address.houseOrBuildingNo!}';
    if (address.addressLine1 != null)
      fullAddress += ', ${address.addressLine1}';
    if (address.addressLine2 != null)
      fullAddress += ', ${address.addressLine2}';
    if (address.pincode != null) fullAddress += ', ${address.pincode}';
    if (address.landmark != null)
      fullAddress += ', Landmark: ${address.landmark}';

    return fullAddress;
  }
}
