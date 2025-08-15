import 'package:curd_assignment/presentation/products/view/cart_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:curd_assignment/presentation/products/model/products_response_model.dart';
import 'package:curd_assignment/presentation/products/cubit/products_cubit.dart';

// Mock ProductsCubit
class MockProductsCubit extends Mock implements ProductsCubit {}

void main() {
  late CartManager cartManager;
  late MockProductsCubit mockCubit;

  setUp(() {
    mockCubit = MockProductsCubit();
    cartManager = CartManager(mockCubit);
  });

  group('CartManager', () {
    test('loadCart should populate items from storage', () async {
      // Arrange
      final mockProducts = [
        ProductsResponseModel(title: 'Item 1', price: 10.0),
        ProductsResponseModel(title: 'Item 2', price: 20.0),
      ];
      when(() => mockCubit.getCartItems()).thenAnswer((_) async => mockProducts);

      // Act
      await cartManager.loadCart();

      // Assert
      expect(cartManager.items.length, 2);
      expect(cartManager.items.first.product.title, 'Item 1');
      expect(cartManager.items.first.quantity, 1);
    });

    test('saveCart should call saveCartItems with current products', () async {
      // Arrange
      final mockProducts = [
        ProductsResponseModel(title: 'Item 1', price: 10.0),
      ];
      cartManager.items.add(CartItem(product: mockProducts.first, quantity: 2));

      when(() => mockCubit.saveCartItems(any())).thenAnswer((_) async => Future.value());

      // Act
      await cartManager.saveCart();

      // Assert
      verify(() => mockCubit.saveCartItems([mockProducts.first])).called(1);
    });

    test('updateQuantity should increase quantity', () {
      // Arrange
      final product = ProductsResponseModel(title: 'Item 1', price: 10.0);
      cartManager.items.add(CartItem(product: product, quantity: 1));

      // Act
      cartManager.updateQuantity(0, 1);

      // Assert
      expect(cartManager.items[0].quantity, 2);
    });

    test('updateQuantity should decrease quantity', () {
      // Arrange
      final product = ProductsResponseModel(title: 'Item 1', price: 10.0);
      cartManager.items.add(CartItem(product: product, quantity: 2));

      // Act
      cartManager.updateQuantity(0, -1);

      // Assert
      expect(cartManager.items[0].quantity, 1);
    });

    test('updateQuantity should remove item if quantity goes below 1', () {
      // Arrange
      final product = ProductsResponseModel(title: 'Item 1', price: 10.0);
      cartManager.items.add(CartItem(product: product, quantity: 1));

      // Act
      cartManager.updateQuantity(0, -1);

      // Assert
      expect(cartManager.items.isEmpty, true);
    });

    test('totalPrice should sum prices correctly', () {
      // Arrange
      final p1 = ProductsResponseModel(title: 'Item 1', price: 10.0);
      final p2 = ProductsResponseModel(title: 'Item 2', price: 20.0);
      cartManager.items.addAll([
        CartItem(product: p1, quantity: 2), // 20
        CartItem(product: p2, quantity: 1), // 20
      ]);

      // Act
      final total = cartManager.totalPrice;

      // Assert
      expect(total, 40.0);
    });
  });
}
