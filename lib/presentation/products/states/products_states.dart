import 'package:datasource/states/data_state.dart';

class ProductsLoadingState extends LoadingState {
  ProductsLoadingState(super.loadingMessage);
}

class ProductsLoadedState extends LoadedState {
  ProductsLoadedState({required super.data});
}
