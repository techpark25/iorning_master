import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(141, 0, 0, 0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Price: ( $totalQuantity items) ',
              style: const TextStyle(fontSize: 10, color: Colors.white),
            ),
            Text(
              'Total Price: ₹$totalPrice',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
