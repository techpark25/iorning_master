import 'package:flutter/material.dart';
import 'presentation/main/main_screen.dart';
import 'package:lottie/lottie.dart';

class OrderPlaced extends StatelessWidget {
  const OrderPlaced({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Booked'),
      ),
      body: InkWell(
        onTap: () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
          (Route<dynamic> route) => false, // Predicate to remove all routes
        ),
        child: Center(
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
              const SizedBox(height: 20), // Add some space between animation and text
              const Text(
                'Order Placed',
                style: TextStyle(
                  fontSize: 24, // Big font size
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                  height:
                      10), // Add space between order placed text and order ID
             
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: OrderPlaced(),
  ));
}
