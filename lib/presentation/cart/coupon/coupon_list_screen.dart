import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'coupon_view_model.dart';

class CouponScreen extends StatefulWidget {
  final double cartTotal;

  const CouponScreen({Key? key, required this.cartTotal}) : super(key: key);

  @override
  _CouponScreenState createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  late CouponViewModel viewModel;
  String? appliedCouponCode; // Track applied coupon

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CouponViewModel>(context, listen: false).getCoupons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Coupons")),
      body: Consumer<CouponViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.loadingOrders) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: viewModel.coupons.length,
            itemBuilder: (context, index) {
              final coupon = viewModel.coupons[index];
              final double minCartAmount = double.tryParse(coupon.minCartAmount ?? '0') ?? 0.0;
              final isApplicable = widget.cartTotal >= minCartAmount;
              final isApplied = coupon.code == appliedCouponCode; // Check if the coupon is already applied

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coupon.code ?? '',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Discount: ₹${coupon.discountAmount}",
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isApplicable
                            ? "✅ Applicable for this cart"
                            : "⚠ Minimum cart amount ₹$minCartAmount required",
                        style: TextStyle(
                          fontSize: 14,
                          color: isApplicable ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: (isApplicable && !isApplied)
                              ? () {
                                  setState(() {
                                    appliedCouponCode = coupon.code; // Disable once applied
                                  });
                                  Navigator.pop(context, coupon); // Pass selected coupon back
                                }
                              : null, // Disable button
                          child: Text(isApplied ? "Applied" : "Apply"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
