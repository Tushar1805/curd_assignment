import 'package:core/di/service_locator.dart';
import 'package:curd_assignment/basecubit/base_cubit.dart';
import 'package:curd_assignment/presentation/products/repository/products_repository.dart';
import 'package:curd_assignment/presentation/products/states/products_states.dart';
import 'package:curd_assignment/resources/app_keys.dart';
import 'package:curd_assignment/resources/app_storage.dart';

class ProductsCubit extends BaseCubit {
  final ProductsRepository _productsRepository;
  ProductsCubit(this._productsRepository);
  final storage = sl<SecureStorage>();

  Future<void> getProducts() async {
    try {
      emit(ProductsLoadingState('Loading Cancellation Reasons'));
      final lang = await storage.readValue(languageCodeKey);
      final response = await _productsRepository.getProducts(
        lang: lang ?? 'en',
      );

      emit(ProductsLoadedState(data: response));
    } catch (e) {
      handleExceptions(e);
    }
  }
}
