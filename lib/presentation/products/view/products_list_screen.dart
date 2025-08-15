import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/app_widgets.dart';
import 'package:core/di/service_locator.dart';
import 'package:core/theme/theme_cubit.dart';
import 'package:core/utils/core_utils.dart';
import 'package:curd_assignment/l10n/app_localizations.dart';
import 'package:curd_assignment/presentation/products/cubit/products_cubit.dart';
import 'package:curd_assignment/presentation/products/model/products_response_model.dart';
import 'package:curd_assignment/presentation/products/states/products_states.dart';
import 'package:curd_assignment/resources/app_colors.dart';
import 'package:curd_assignment/resources/app_images.dart';
import 'package:curd_assignment/resources/app_widgets.dart';
import 'package:curd_assignment/routes/app_routes.dart';
import 'package:datasource/states/data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final productsCubit = sl<ProductsCubit>();
  final themeCubit = sl<ThemeCubit>();
  List<ProductsResponseModel>? productsResponse;
  FToast? fToast;

  void loadProducts() async {
    await productsCubit.getProducts();
  }

  @override
  void initState() {
    fToast = FToast();
    fToast!.init(context);
    loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.width * 0.15),
        child: CustomStatusBarWidget(
          title: AppLocalizations.of(context)!.productsString,
        ),
      ),
      drawer: Drawer(
        backgroundColor:
            Theme.of(context).brightness == Brightness.light ? whiteColor : darkBackground,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.green
                      : splashLightBackground),
              child: Text(AppLocalizations.of(context)!.settingsString,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: whiteColor)),
            ),
            ListTile(
              leading: Icon(
                Icons.language,
                color:
                    Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
              ),
              title: Text(
                AppLocalizations.of(context)!.changeLanguageString,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                context.pushNamed(
                  setLanguageScreen,
                  extra: {
                    'onPop': true,
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.brightness_6,
                color:
                    Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
              ),
              title: Text(
                AppLocalizations.of(context)!.changeTheme,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                themeCubit.toggleTheme();
              },
            ),
          ],
        ),
      ),
      body: BlocConsumer(
        bloc: productsCubit,
        listener: (final context, final state) {
          if (state is ProductsLoadedState) {
            productsResponse = state.data as List<ProductsResponseModel>?;
          } else if (state is ErrorState) {
            showToast(
              gravity: ToastGravity.CENTER,
              context: context,
              fToast: fToast!,
              msg: state.errorMessage,
              duration: 5,
            );
          }
        },
        builder: (final context, final state) {
          if (state is ProductsLoadingState) {
            return const Center(
              child: LoadingWithoutText(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: productsResponse?.length,
                itemBuilder: (context, index) {
                  final product = productsResponse?[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: CachedNetworkImage(
                              imageUrl: product?.image ?? sampleNetworkImage,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(product?.title ?? '',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "\$${product?.price ?? 0}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomElevatedButton(
                            name: AppLocalizations.of(context)!.addToCartString,
                            borderRadius: 8,
                            alignment: Alignment.center,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
