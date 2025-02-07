import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/orders/model/order.dart';
import '../../detail/order_detail_screen.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailScreen(orderId: order.id),
          ),
        );
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left Side: Order ID and DateTime
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "#${order.orderRefNum}" ?? 'N/A',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    DateFormat('dd-mm-yyyy, hh:mm a').format(order.createdAt!),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              // Right Side: Price, Status, and Icon
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        order.total.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      buildStatusText(order.status ?? 1),
                    ],
                  ),
                  const SizedBox(width: 10),
                     Icon(Icons.arrow_forward_ios, size: 18),
                
                ],
              ),
            ],
          ),
        ),
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
