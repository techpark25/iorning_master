import 'package:flutter/material.dart';

import '../../../data/cart/model/cart_list_response.dart';
import 'cart_card.dart';

class CartList extends StatelessWidget {
  final List<Cart> cart; // Accept a list of Cart instead of Product
  final Function(int) onAddToCart;
  final Function(int) onRemoveFromCart;

  const CartList({
    required this.cart,
    required this.onAddToCart,
    required this.onRemoveFromCart,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];

          return CartCard(
            onAddToCart: onAddToCart,
            onRemoveFromCart: onRemoveFromCart,
            cart: cartItem, // Default cart if not found
          );
        });
  }
}
