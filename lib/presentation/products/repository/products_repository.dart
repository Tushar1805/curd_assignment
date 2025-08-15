
import 'package:curd_assignment/presentation/products/model/products_response_model.dart';
import 'package:curd_assignment/resources/app_api.dart';
import 'package:datasource/base_repository.dart';
import 'package:datasource/network/api_call_type.dart';

class ProductsRepository extends BaseRepository {
  Future<List<ProductsResponseModel>> getProducts({
    required final String lang,
  }) async {
    final responseData = await fetchData(
      apiCallType: ApiCallType.get,
      apiUrl: getProductsUrl,
    );


    if (responseData is List) {
      return responseData
          .map((e) => ProductsResponseModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("Invalid response format: Expected a List");
    }
  }
}
