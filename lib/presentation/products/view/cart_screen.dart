import 'package:curd_assignment/resources/app_colors.dart';
import 'package:curd_assignment/resources/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:curd_assignment/resources/app_widgets.dart';
import 'package:curd_assignment/l10n/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:curd_assignment/presentation/products/model/products_response_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartStorage = CartStorage(const FlutterSecureStorage());
  List<CartItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    final items = await cartStorage.getCartItems();
    setState(() {
      cartItems = items.map((e) => CartItem(product: e, quantity: 1)).toList();
    });
  }

  Future<void> _saveCart() async {
    await cartStorage.saveCartItems(cartItems.map((e) => e.product).toList());
  }

  void _updateQuantity(int index, int change) {
    setState(() {
      cartItems[index].quantity += change;
      if (cartItems[index].quantity < 1) {
        cartItems.removeAt(index);
      }
    });
    _saveCart();
  }

  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + (item.product.price ?? 0) * item.quantity);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.width * 0.15),
        child: CustomStatusBarWidget(
          title: AppLocalizations.of(context)!.cartString,
        ),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text(
                AppLocalizations.of(context)!.noItemsString,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: item.product.image ?? '',
                            width: 50,
                            height: 50,
                            placeholder: (_, __) => const CircularProgressIndicator(),
                            errorWidget: (_, __, ___) => const Icon(Icons.error),
                          ),
                          title: Text(
                            item.product.title ?? '',
                            style: theme.textTheme.bodyLarge,
                          ),
                          subtitle: Text(
                            "\$${item.product.price ?? 0}",
                            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.green),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  color: theme.brightness == Brightness.light
                                      ? Colors.black
                                      : primaryColor,
                                ),
                                onPressed: () => _updateQuantity(index, -1),
                              ),
                              Text(
                                '${item.quantity}',
                                style: theme.textTheme.bodyMedium,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  color: theme.brightness == Brightness.light
                                      ? Colors.black
                                      : primaryColor,
                                ),
                                onPressed: () => _updateQuantity(index, 1),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.totalString}: \$${totalPrice.toStringAsFixed(2)}",
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      CustomElevatedButton(
                        name: AppLocalizations.of(context)!.checkoutString,
                        borderRadius: 8,
                        alignment: Alignment.center,
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

class CartItem {
  final ProductsResponseModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}
