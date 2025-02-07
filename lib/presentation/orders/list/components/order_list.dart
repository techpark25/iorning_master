import 'package:flutter/material.dart';

import '../../detail/order_detail_screen.dart';
import '../../../../data/orders/model/order.dart';
import 'order_card.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key, required this.orders});
  final List<Order> orders;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return OrderCard(
            order: orders[index],

          );
        },
      ),
    );
  }
}
