import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/cart/model/cart_list_response.dart';
import '../../../data/product/model/product.dart';
import '../cart_view_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Cart cart;

  final Function(int productId) onAddToCart;
  final Function(int cartId) onRemoveFromCart;

  const ProductCard({
    required this.product,
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
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              product.image ?? '',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? '',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('Price: ₹${product.price ?? 0}'),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    // Decrease the quantity when the Remove button is clicked
                    // if (productQuantity > 0) {
                      onRemoveFromCart(cart.id ?? 0); // Decrease quantity
                    // }
                  },
                ),
                // Display quantity between remove and add buttons
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '$productQuantity',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // Increase the quantity when the Add button is clicked
                    onAddToCart(product.id ?? 0); // Increment quantity
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
