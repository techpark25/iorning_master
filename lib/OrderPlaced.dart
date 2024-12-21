import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderPlaced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Booked'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Lottie.asset(
              'assets/img/animation-confirm.json',
              width: 300,
              height: 300,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 20), // Add some space between animation and text
            Text(
              'Order Placed',
              style: TextStyle(
                fontSize: 24, // Big font size
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
                height: 10), // Add space between order placed text and order ID
            Text(
              'Order ID: #123456',
              style: TextStyle(
                fontSize: 16, // Smaller font size
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: OrderPlaced(),
  ));
}
