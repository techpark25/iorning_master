import 'package:flutter/material.dart';
import 'package:laundry_application/presentation/orders/detail/order_detail_view_model.dart';
import 'package:provider/provider.dart';

import 'components/detail_card.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key, this.orderId});
  final int? orderId;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late OrderDetailViewModel viewModel;

  @override
  void initState() {
    viewModel = Provider.of<OrderDetailViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.reset();
      viewModel.getOrderDetail(widget.orderId);
      // viewModel.getShops(widget.categoryId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Sample values for demonstration
   

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDC846),
        flexibleSpace: Container(
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
        ),
        title: const Text(
          "Order Details",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<OrderDetailViewModel>(
        builder: (context, viewModel, child) {
           if (viewModel.orderDetail?.orders == null) {
          return const Center(
            child: Text("No order details available"),
          );
        }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DetailCard(
                  details: viewModel.orderDetail!.orders!,
                ),
                const SizedBox(height: 20),
                                Card(child: _buildDetailRow('Total'," ₹${viewModel.orderDetail?.overallTotal.toString()}" ?? '')),

                // DetailCard(
                //   details: const [
                //     {"title": "Subtotal", "value": "\$${subtotal.toString()}"},
                //     {"title": "Total", "value": "\$${total.toStringAsFixed(2)}"},
                //   ],
                //   divider: true, // Add divider between rows
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
 Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
