import 'package:flutter/material.dart';
import 'cart_view_model.dart';
import 'product_view_model.dart';
import 'package:provider/provider.dart';

import 'components/add_to_cart_button.dart';
import 'components/category_button_list.dart';
import 'components/product_list.dart';
import 'components/total_price_widget.dart';

class ProductScreen extends StatefulWidget {
  final String? title;
  final int? categoryId;
  final int? subcategory;
  const ProductScreen(
      {super.key, this.title, this.categoryId, this.subcategory});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductViewModel viewModel;
  late CartViewModel cartViewModel;

  @override
  void initState() {
    viewModel = Provider.of<ProductViewModel>(context, listen: false);
    cartViewModel = Provider.of<CartViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.reset();
      viewModel.getProducts(widget.categoryId,
          widget.subcategory); // Pass the correct subcategory
      cartViewModel.getCart();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'Select Items'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<ProductViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 4),
              Center(
                child: SubCategoriesList(
                  categories: viewModel.subcategories,
                  activeCategory: viewModel.activeCategory,
                  onTap: (subcategory) {
                    if (subcategory == null || subcategory.id == 0) {
                      viewModel.getProducts(widget.categoryId, null);
                    } else {
                      viewModel.getProducts(widget.categoryId, subcategory.id);
                    }
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              if (viewModel.loadingItems) ...[
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ] else if (viewModel.products.isEmpty) ...[
                Expanded(
                  child: Center(
                    child: Text(
                      'No products available now in this category',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: Consumer<CartViewModel>(
                    builder: (context, cartViewModel, child) {
                      if (cartViewModel.loadingCart) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ProductList(
                        products: viewModel.products,
                        cart: cartViewModel.cartItems,
                        onAddToCart: (productId) {
                          cartViewModel.addToCart(productId);
                        },
                        onRemoveFromCart: (cartId) {
                          cartViewModel.removeFromCart(cartId);
                          print(cartId);
                        },
                      );
                    },
                  ),
                ),
              ],
              Consumer<CartViewModel>(
                builder: (context, cartViewModel, child) {
                  return TotalPriceWidget(
                    totalQuantity: cartViewModel.totalQuantity ?? 0,
                    totalPrice: cartViewModel.totalPrice.toInt(),
                  );
                },
              ),
              const AddToCartButton(),
            ],
          );
        },
      ),
    );
  }
}
