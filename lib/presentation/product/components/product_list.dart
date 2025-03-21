import 'package:flutter/material.dart';

import '../../../data/cart/model/cart_list_response.dart';
import '../../../data/product/model/product.dart';
import 'product_card.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;
  final List<Cart> cart;

  final Function(int productId) onAddToCart;
  final Function(int cartId) onRemoveFromCart;

  const ProductList({
    required this.products,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    // Create a map from cart items based on productId
    final Map<int, Cart> cartMap = {
      for (var c in cart)
        if (c.productId != null)
          c.productId!: c, // Only include cart items with non-null productId
    };

    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        // Get the corresponding cart item for the product, or use a default one if not found
        final Cart? productCart = cartMap[products[index].id];

        return ProductCard(
          product: products[index],
          onAddToCart: onAddToCart,
          onRemoveFromCart: onRemoveFromCart,
          cart: productCart ??
              Cart(
                  productId: products[index].id!,
                  quantity: productCart?.quantity,
                  id: null,
                  userId: null,
                  createdAt: null,
                  updatedAt: null,
                  product: null), // Default cart if not found
        );
      },
    );
  }
}
