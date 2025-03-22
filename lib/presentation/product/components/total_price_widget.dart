import 'package:flutter/material.dart';
import 'package:laundry_application/themes.dart';

class TotalPriceWidget extends StatelessWidget {
  final int totalQuantity;
  final int totalPrice;

  const TotalPriceWidget({
    required this.totalQuantity,
    required this.totalPrice,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 21, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(255, 185, 141, 255), width: 1),
        color: const Color.fromARGB(255, 238, 228, 255),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Price: ( $totalQuantity items) ',
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppThemes.darkBackgroundColor),
            ),
            Text(
              'Total Price: ₹$totalPrice',
              style: const TextStyle(
                  fontSize: 16,
                  color: AppThemes.darkBackgroundColor,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
