// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/di/service_locator.dart';
import 'package:curd_assignment/presentation/products/cubit/products_cubit.dart';
import 'package:curd_assignment/resources/app_colors.dart';
import 'package:curd_assignment/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:curd_assignment/presentation/products/model/products_response_model.dart';
import 'package:curd_assignment/resources/app_images.dart';
import 'package:curd_assignment/resources/app_widgets.dart';
import 'package:curd_assignment/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductsResponseModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final productsCubit = sl<ProductsCubit>();
  bool _isPressed = false;
  bool _isAdded = false;

  @override
  void initState() {
    super.initState();
    _checkIfInCart();
  }

  /// Check if product is already in cart
  Future<void> _checkIfInCart() async {
    final items = await productsCubit.getCartItems();
    final exists = items.any((item) => item.id == widget.product.id);
    if (exists) {
      setState(() {
        _isAdded = true;
      });
    }
  }

  /// Add product to cart
  Future<void> addToCart(ProductsResponseModel product) async {
    final items = await productsCubit.getCartItems();
    items.add(product);
    await productsCubit.saveCartItems(items);
  }

  void _onAddToCart() async {
    if (_isAdded) {
      // Already in cart, go to cart
      context.pushNamed(cartScreen);
      return;
    }

    // Button press animation
    setState(() {
      _isPressed = true;
    });

    await addToCart(widget.product);

    // Release animation
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() {
      _isPressed = false;
      _isAdded = true;
    });

    // Navigate to cart after short delay
    await Future.delayed(const Duration(milliseconds: 500));
    context.pushNamed(cartScreen);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.width * 0.15),
        child: CustomStatusBarWidget(
          title: widget.product.title ?? '',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: widget.product.image ?? sampleNetworkImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.broken_image, size: 60, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),

            /// Title
            Text(
              widget.product.title ?? '',
              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            /// Price
            Text(
              "\$${widget.product.price?.toStringAsFixed(2) ?? '0.00'}",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            /// Category
            Text(
              "${AppLocalizations.of(context)!.categoryString}: ${widget.product.category ?? ''}",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 8),

            /// Rating
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 20),
                const SizedBox(width: 4),
                Text(
                  "${widget.product.rating?.rate ?? 0} (${widget.product.rating?.count ?? 0} reviews)",
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Description
            Text(
              widget.product.description ?? '',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),

            const Spacer(),

            /// Add to Cart Button with Animation
            AnimatedScale(
              scale: _isPressed ? 0.95 : 1.0,
              duration: const Duration(milliseconds: 150),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: CustomElevatedButton(
                  name: _isAdded
                      ? AppLocalizations.of(context)!.addedToCartString
                      : AppLocalizations.of(context)!.addToCartString,
                  borderRadius: 8,
                  alignment: Alignment.center,
                  backgroundColor: _isAdded ? Colors.green : theme.primaryColor,
                  onPressed: _onAddToCart,
                ),
              ),
            ),

            SizedBox(height: size.width * 0.2),
          ],
        ),
      ),
    );
  }
}
