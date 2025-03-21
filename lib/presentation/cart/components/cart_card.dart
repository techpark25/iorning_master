import 'package:flutter/material.dart';
import 'package:laundry_application/themes.dart';
import 'package:laundry_application/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../data/cart/model/cart_list_response.dart';
import '../../../data/product/model/product.dart';
import '../../product/cart_view_model.dart';

class CartCard extends StatelessWidget {
  final Cart cart;

  final Function(int productId) onAddToCart;
  final Function(int cartId) onRemoveFromCart;

  const CartCard({
    required this.onAddToCart,
    required this.onRemoveFromCart,
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    final cartViewModel = context.watch<CartViewModel>();

    // Find the product's quantity in the cart, default to 0 if not found
    int productQuantity = cart.quantity ?? 0;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              cart.product?.image ?? '',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MyAppDateUtils.capitalizeFirstLetter(
                        cart.product?.name ?? ''),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '₹${cart.product?.price ?? 0}',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 0, 139, 12),
                        fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 255, 171, 173),
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppThemes.lightSucessColor,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Prevents unnecessary space
                children: [
                  SizedBox(
                    width: 28, // Adjust button width
                    height: 28, // Adjust button height
                    child: IconButton(
                      padding: EdgeInsets.zero, // Removes default padding
                      constraints:
                          BoxConstraints(), // Prevents extra constraints
                      icon: Icon(
                        Icons.remove,
                        size: 16,
                        color: AppThemes.primaryColor,
                      ),
                      onPressed: () {
                        onRemoveFromCart(cart.id ?? 0);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30, // Restrict width to avoid extra spacing
                    child: Center(
                      child: Text(
                        '$productQuantity',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: IconButton(
                      padding: EdgeInsets.zero, // Removes default padding
                      constraints:
                          BoxConstraints(), // Prevents extra constraints
                      icon: Icon(
                        Icons.add,
                        size: 16,
                        color: AppThemes.primaryColor,
                      ),
                      onPressed: () {
                        onAddToCart(cart.product?.id ?? 0);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
