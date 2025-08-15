import 'dart:convert';

import 'package:core/di/service_locator.dart';
import 'package:core/utils/core_utils.dart';
import 'package:curd_assignment/basecubit/base_cubit.dart';
import 'package:curd_assignment/presentation/products/model/products_response_model.dart';
import 'package:curd_assignment/presentation/products/repository/products_repository.dart';
import 'package:curd_assignment/presentation/products/states/products_states.dart';
import 'package:curd_assignment/resources/app_keys.dart';
import 'package:curd_assignment/resources/app_storage.dart';

class ProductsCubit extends BaseCubit {
  final ProductsRepository _productsRepository;
  ProductsCubit(this._productsRepository);
  final storage = sl<SecureStorage>();

  Future<List<ProductsResponseModel>> getCachedProducts() async {
    final jsonString = await storage.readValue(productsKey);
    if (jsonString == null) return [];
    final List<dynamic> data = jsonDecode(jsonString);
    return data.map((e) => ProductsResponseModel.fromJson(e)).toList();
  }

  Future<void> saveProducts(List<ProductsResponseModel> items) async {
    final jsonString = jsonEncode(items.map((e) => e.toJson()).toList());
    await storage.saveValue(key: productsKey, value: jsonString);
  }

  Future<List<ProductsResponseModel>> getCartItems() async {
    final jsonString = await storage.readValue(cartItemKey);
    if (jsonString == null) return [];
    final List<dynamic> data = jsonDecode(jsonString);
    return data.map((e) => ProductsResponseModel.fromJson(e)).toList();
  }

  Future<void> saveCartItems(List<ProductsResponseModel> items) async {
    final jsonString = jsonEncode(items.map((e) => e.toJson()).toList());
    await storage.saveValue(key: cartItemKey, value: jsonString);
  }

  Future<void> getProducts() async {
    emit(ProductsLoadingState('Loading products data'));
    final data = await getCachedProducts();
    if (data.isNotEmpty) {
      customPrint('Cached data');
      emit(ProductsLoadedState(data: data));
    } else {
      try {
        final lang = await storage.readValue(languageCodeKey);
        final response = await _productsRepository.getProducts(
          lang: lang ?? 'en',
        );

        saveProducts(response);

        emit(ProductsLoadedState(data: response));
      } catch (e) {
        handleExceptions(e);
      }
    }
  }
}
