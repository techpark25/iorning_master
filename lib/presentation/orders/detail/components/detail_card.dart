import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/orders/model/order.dart';

class DetailCard extends StatelessWidget {
  final Order details;
  final bool divider;

  const DetailCard({
    super.key,
    required this.details,
    this.divider = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDetailRow('Customer Name', ""),
          _buildDetailRow('Order ID', "#${details.orderRefNum}"),
          _buildDetailRow(
            'Date and Time',
            DateFormat('dd-MM-yyyy, hh:mm a').format(
              details.createdAt!.add(const Duration(hours: 5, minutes: 30)),
            ),
          ),
          _buildDetailRow('Order Location', details.pickupLocation ?? "N/A"),
          _buildDetailRow(
            'Pickup Date',
            DateFormat('dd-MM-yyyy').format(details.pickupDate!),
          ),
          _buildDetailRow('Pickup Time', details.timeSlot.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                flex: 3,
                child: Text(
                  'Status',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(child: buildStatusText(details.status ?? 0)),
            ],
          ),
          const Divider(thickness: 1.0),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

Map<int, Map<String, dynamic>> orderStatusMap = {
  10: {'name': 'Order Placed', 'color': Colors.blue},
  20: {'name': 'Order Accepted', 'color': Colors.lightBlue},
  30: {'name': 'Order Packed', 'color': Colors.orange},
  40: {'name': 'Driver Assigned', 'color': Colors.purple},
  50: {'name': 'Order Delivered', 'color': Colors.green},
  60: {'name': 'Order Cancelled', 'color': Colors.red},
  70: {'name': 'Order Picked Up', 'color': Colors.brown},
};

Widget buildStatusText(int status) {
  final statusDetails = orderStatusMap[status];
  if (statusDetails == null) {
    return const Text(
      'Unknown Status',
      style: TextStyle(
          color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),
    );
  }

  return Text(
    statusDetails['name'],
    style: TextStyle(
      color: statusDetails['color'],
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
  );
}
