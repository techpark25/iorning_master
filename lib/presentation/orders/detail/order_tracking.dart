import 'package:flutter/material.dart';
import 'package:laundry_application/themes.dart';
import 'package:timeline_tile/timeline_tile.dart';

void main() {
  runApp(OrderTrackingApp());
}

class OrderTrackingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OrderTrackingScreen(),
    );
  }
}

class OrderTrackingScreen extends StatelessWidget {
  final List<OrderStatus> orderStatuses = [
    OrderStatus("Order Booked", "03:32 PM | 29 Jul,2023", true),
    OrderStatus("Order Picked Up", "04:13 PM | 29 Jul,2023", true),
    OrderStatus("Reached At Hub", "04:35 PM | 29 Jul,2023", true),
    OrderStatus("Order Processing", "05:36 PM | 29 Jul,2023", true),
    OrderStatus("Order Processed", "05:53 PM | 29 Jul,2023", true),
    OrderStatus("Out for Delivery", "", false),
    OrderStatus("Delivered", "", false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Status Tracking"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 40.0, vertical: 10.0), // Added padding
        child: ListView.builder(
          itemCount: orderStatuses.length,
          itemBuilder: (context, index) {
            final orderStatus = orderStatuses[index];
            return Padding(
              padding: const EdgeInsets.only(
                  bottom: 15.0), // Spacing between timeline items
              child: TimelineTile(
                isFirst: index == 0,
                isLast: index == orderStatuses.length - 1,
                indicatorStyle: IndicatorStyle(
                  width: 25,
                  color: orderStatus.isCompleted
                      ? AppThemes.primaryColor
                      : Colors.grey,
                  iconStyle: orderStatus.isCompleted
                      ? IconStyle(iconData: Icons.check, color: Colors.white)
                      : null,
                ),
                beforeLineStyle: LineStyle(
                  color: orderStatus.isCompleted
                      ? AppThemes.primaryColor
                      : Colors.grey,
                  thickness: 2,
                ),
                endChild: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(orderStatus.title,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: orderStatus.isCompleted
                                  ? AppThemes.primaryColor
                                  : Colors.grey)),
                      if (orderStatus.time.isNotEmpty)
                        Text(orderStatus.time,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class OrderStatus {
  final String title;
  final String time;
  final bool isCompleted;

  OrderStatus(this.title, this.time, this.isCompleted);
}
