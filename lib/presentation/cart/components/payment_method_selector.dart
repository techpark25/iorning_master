import 'package:flutter/material.dart';

class PaymentMethodSelector extends StatelessWidget {
  final bool isCOD;
  final bool isOnlinePayment;
  final Function(bool) onCODChanged;
  final Function(bool) onOnlinePaymentChanged;

  const PaymentMethodSelector({
    Key? key,
    required this.isCOD,
    required this.isOnlinePayment,
    required this.onCODChanged,
    required this.onOnlinePaymentChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Payment Method",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Checkbox(
                    value: isCOD,
                    onChanged: (value) => onCODChanged(value ?? false),
                  ),
                  const Text("COD"),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Checkbox(
                    value: isOnlinePayment,
                    onChanged: (value) => onOnlinePaymentChanged(value ?? false),
                  ),
                  const Text("Online Payment"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
