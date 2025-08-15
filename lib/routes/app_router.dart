import 'package:curd_assignment/presentation/onboarding/select_lang_screen.dart';
import 'package:curd_assignment/presentation/onboarding/splash_screen.dart';
import 'package:curd_assignment/presentation/products/model/products_response_model.dart';
import 'package:curd_assignment/presentation/products/view/cart_screen.dart';
import 'package:curd_assignment/presentation/products/view/product_details_screen.dart';
import 'package:curd_assignment/presentation/products/view/products_list_screen.dart';
import 'package:curd_assignment/routes/app_routes.dart';
import 'package:curd_assignment/routes/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage<T> slideTransitionPage<T>({
  required Widget child,
  required LocalKey key,
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final offsetAnimation = Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeInOut)).animate(animation);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

final GoRouter router = GoRouter(
  initialLocation: splashScreen,
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: [
    GoRoute(
      name: splashScreen,
      path: splashScreen,
      pageBuilder: (context, state) => slideTransitionPage(
        key: state.pageKey,
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      name: setLanguageScreen,
      path: setLanguageScreen,
      pageBuilder: (final context, final state) {
        final params = state.extra as Map<String, dynamic>?;
        return slideTransitionPage(
          key: state.pageKey,
          child: SelectLangScreen(
            onPop: params?['onPop'] as bool?,
          ),
        );
      },
    ),
    GoRoute(
      name: productListScreen,
      path: productListScreen,
      pageBuilder: (context, state) => slideTransitionPage(
        key: state.pageKey,
        child: const ProductListScreen(),
      ),
    ),
    GoRoute(
      name: productDetailsScreen,
      path: productDetailsScreen,
      pageBuilder: (final context, final state) {
        final params = state.extra as Map<String, dynamic>?;
        return slideTransitionPage(
          key: state.pageKey,
          child: ProductDetailsScreen(
            product: params?['product'] as ProductsResponseModel,
          ),
        );
      },
    ),
    GoRoute(
      name: cartScreen,
      path: cartScreen,
      pageBuilder: (context, state) => slideTransitionPage(
        key: state.pageKey,
        child: const CartScreen(),
      ),
    ),
  ],
);
