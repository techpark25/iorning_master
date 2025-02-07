import 'package:flutter/material.dart';

class OrderSummary extends StatelessWidget {
  final int itemPrice;
  final double deliveryFee;
  final double totalAmount;

  const OrderSummary({
    Key? key,
    required this.itemPrice,
    required this.deliveryFee,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _priceRow("Item", "\₹$itemPrice"),
          _priceRow("Delivery", "\₹$deliveryFee"),
          const Divider(color: Colors.grey),
          _priceRow("Total", "\₹${totalAmount.toStringAsFixed(2)}", isBold: true),
        ],
      ),
    );
  }

  Widget _priceRow(String title, String amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
