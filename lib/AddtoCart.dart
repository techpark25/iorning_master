import 'package:flutter/material.dart';
import 'package:laundry_app/Schedule.dart';

class AddToCart extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    // Example product data
    {
      'image': 'assets/img/shirt.png', // Replace with your image path
      'name': 'Product 1',
      'type': 'Ironing',
      'price': 100.0,
      'quantity': 1,
    },
    {
      'image': 'assets/img/jean.png', // Replace with your image path
      'name': 'Product 2',
      'type': 'Washing',
      'price': 150.0,
      'quantity': 1,
    },
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0), // AppBar height
        child: AppBar(
          title: const Text(
            'Your Cart Items',
            style: TextStyle(color: Colors.white), // White header text
          ),
          backgroundColor:
              Colors.transparent, // Make AppBar background transparent
          elevation: 0, // Remove shadow
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFDC846), // Golden Yellow
                  Color(0xFFD32943), // Red
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Product list section
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductBox(product: product);
                },
              ),
            ),

            // Schedule Now button at the bottom
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Transparent background
                  shadowColor: Colors.transparent, // Remove shadow
                  padding: EdgeInsets.zero, // No padding to fit the gradient
                ),
                onPressed: () {
                  // Navigate to the SchedulePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Schedule()),
                  );
                },
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFDC846), // Golden Yellow
                        Color(0xFFD32943), // Red
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity, // Full width button
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: const Text(
                      'Schedule Now',
                      style: TextStyle(
                          color: Colors.white), // Text color for the button
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductBox extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductBox({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(12.0), // Rounded corners with more curve
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Left side: product image, name, type, and price
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                product['image'],
                width: 80.0,
                height: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Black text for product name
                    ),
                  ),
                  Text(
                    product['type'],
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '₹${product['price']}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green, // Green color for price
                    ),
                  ),
                ],
              ),
            ),

            // Right side: quantity controls and delete icon
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Decrease quantity logic
                      },
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                    ),
                    Text(
                      '${product['quantity']}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Increase quantity logic
                      },
                      icon: const Icon(Icons.add_circle, color: Colors.green),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    // Delete product logic
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
