import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:curd_assignment/presentation/products/model/products_response_model.dart';


class SecureStorage {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  IOSOptions _getIOSOptions() => const IOSOptions(
        accountName: 'curd_assignment',
      );

  Future<void> saveValue({required final String? value, required final String key}) async {
    await const FlutterSecureStorage().write(
      key: key,
      value: value,
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),
    );
  }

  Future<String?> readValue(final String key) => const FlutterSecureStorage().read(
        key: key,
        aOptions: _getAndroidOptions(),
        iOptions: _getIOSOptions(),
      );

  Future<void> clearAll() => const FlutterSecureStorage().deleteAll();

  Future<void> clearData(final String key) async {
    await const FlutterSecureStorage().delete(key: key);
  }
}


class CartStorage {
  static const _key = "cart_items";
  final FlutterSecureStorage storage;

  CartStorage(this.storage);

  Future<List<ProductsResponseModel>> getCartItems() async {
    final jsonString = await storage.read(key: _key);
    if (jsonString == null) return [];
    final List<dynamic> data = jsonDecode(jsonString);
    return data.map((e) => ProductsResponseModel.fromJson(e)).toList();
  }

  Future<void> saveCartItems(List<ProductsResponseModel> items) async {
    final jsonString = jsonEncode(items.map((e) => e.toJson()).toList());
    await storage.write(key: _key, value: jsonString);
  }
}
