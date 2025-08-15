import 'package:core/localization/language_cubit.dart';
import 'package:core/theme/theme_cubit.dart';
import 'package:curd_assignment/presentation/products/cubit/products_cubit.dart';
import 'package:curd_assignment/presentation/products/repository/products_repository.dart';
import 'package:curd_assignment/resources/app_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.I;

void setupServiceLocator() async {
  //* Repositories
  sl.registerFactory<SecureStorage>(SecureStorage.new);
  sl.registerFactory<ProductsRepository>(ProductsRepository.new);
  
  //* Cubits
  sl.registerLazySingleton<ThemeCubit>(
    ThemeCubit.new,
  );
  sl.registerLazySingleton<LanguageCubit>(
    LanguageCubit.new,
  );
  sl.registerSingleton<ProductsCubit>(
    ProductsCubit(sl<ProductsRepository>()),
  );
}
