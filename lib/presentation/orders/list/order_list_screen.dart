import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/order_list.dart';
import 'order_list_view_model.dart';
import '../../main/main_screen.dart';
import 'components/gradient_app_bar.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  late OrderListViewModel viewModel;

  @override
  void initState() {
    viewModel = Provider.of<OrderListViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.getOrders();
      // viewModel.getShops(widget.categoryId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order List"),
        
      ),
    
      body: Consumer<OrderListViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              if (viewModel.loadingOrders) ...[
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ] else if (viewModel.orders.isEmpty) ...[
                Expanded(
                  child: Center(
                    child: Text(
                      'No Orders available ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: OrderList(
                    orders: viewModel.orders,
                  ),
                )
              ],
            ],
          );
        },
      ),
    );
  }
}
