import 'package:flutter/material.dart';
import 'package:laundry_application/themes.dart';
import '../../../data/address/data/address.dart';
import '../../address/location_search_screen.dart';

class BottomNavBar extends StatelessWidget {
  final double bottomHeight;
  final List<Address> addressList; // Changed to store Address objects
  final double totalAmount;
  final bool isTimeSelected;
  final bool isDateSelected;
  final Address? address;
  final bool activeStatus;
  final VoidCallback onOnlinePayment;
  final VoidCallback onCOD;

  const BottomNavBar({
    Key? key,
    required this.bottomHeight,
    required this.addressList,
    required this.totalAmount,
    required this.isTimeSelected,
    required this.isDateSelected,
    required this.onOnlinePayment,
    required this.onCOD,
    this.address,
    required this.activeStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: bottomHeight,
      color: Colors.white,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LocationSearchScreen()),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on, color: AppThemes.primaryColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Delivering to",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          activeStatus && address != null
                              ? _getFullAddress(address!)
                              : 'Enter your location',
                          overflow: TextOverflow
                              .ellipsis, // Prevents text from overflowing
                          maxLines: 1, // Ensures it fits in one line
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
            // Divider Line
            const Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 8), // Space around divider
              child: Divider(
                color: Color.fromARGB(
                    255, 215, 215, 215), // Change color if needed
                thickness: 1, // Adjust thickness
                height: 1, // Ensures the divider is thin
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "To Pay",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        "₹${totalAmount.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: isTimeSelected && isDateSelected
                        ? onOnlinePayment
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      "Pay Online",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: isTimeSelected && isDateSelected ? onCOD : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppThemes.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      "Pay Cash",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getFullAddress(Address address) {
    List<String> addressParts = [];

    if (address.name != null) addressParts.add(address.name!);
    if (address.houseOrBuildingNo != null)
      addressParts.add(address.houseOrBuildingNo!);
    if (address.addressLine1 != null) addressParts.add(address.addressLine1!);
    if (address.addressLine2 != null) addressParts.add(address.addressLine2!);
    if (address.pincode != null)
      addressParts.add("Pincode: ${address.pincode}");
    if (address.landmark != null)
      addressParts.add("Landmark: ${address.landmark}");

    return addressParts.join(', ');
  }
}
