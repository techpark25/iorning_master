import 'package:flutter/material.dart';
import 'MainScreen.dart';
import 'OrderDetail.dart'; // Make sure to import the OrderDetail page

class OrderList extends StatelessWidget {
  const OrderList({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFDC846), // Golden Yellow
                Color(0xFFD32943), // Red
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Transparent to show gradient
            elevation: 0, // Removes shadow
            title: const Text(
              "Order List",
              style: TextStyle(color: Colors.white), // Ensure text is visible
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MainScreen()), // Navigate to MainScreen
                );
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: 10, // Replace with your order list length
          itemBuilder: (context, index) {
            return _buildOrderBox(
              orderId:
                  "Order ID : #12345${index + 1}", // Replace with actual order ID
              dateTime:
                  "2024-12-20 12:45 PM", // Replace with actual date & time
              price: "\₹50.00", // Replace with actual price
              status: "Delivered", // Replace with actual status
              onViewDetails: () {
                // Navigate to OrderDetail page without any parameter
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderDetail(), // No parameters
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Widget to build each order box
  Widget _buildOrderBox({
    required String orderId,
    required String dateTime,
    required String price,
    required String status,
    required VoidCallback onViewDetails,
  }) {
    return Card(
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
                  orderId,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 5),
                Text(
                  dateTime,
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
                      price,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      status,
                      style: TextStyle(
                        color: status == "Delivered"
                            ? Colors.green
                            : Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  onPressed: onViewDetails,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
