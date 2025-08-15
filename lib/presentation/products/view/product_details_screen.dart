import 'package:cached_network_image/cached_network_image.dart';
import 'package:curd_assignment/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:curd_assignment/presentation/products/model/products_response_model.dart';
import 'package:curd_assignment/resources/app_images.dart';
import 'package:curd_assignment/resources/app_widgets.dart';
import 'package:curd_assignment/l10n/app_localizations.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductsResponseModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
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

            // Title
            Text(
              widget.product.title ?? '',
              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Price
            Text(
              "\$${widget.product.price?.toStringAsFixed(2) ?? '0.00'}",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Category
            Text(
              "${AppLocalizations.of(context)!.categoryString}: ${widget.product.category ?? ''}",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 8),

            // Rating
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

            // Description
            Text(
              widget.product.description ?? '',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),

            const Spacer(),

            // Add to cart button
            CustomElevatedButton(
              name: AppLocalizations.of(context)!.addToCartString,
              borderRadius: 8,
              alignment: Alignment.center,
              onPressed: () {
                // TODO: Implement add to cart logic
              },
            ),

            SizedBox(height: size.width * 0.2),
          ],
        ),
      ),
    );
  }
}
