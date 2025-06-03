import 'package:dio/dio.dart';
import 'package:groceries/core/network/dio_client.dart';
import 'package:groceries/core/network/urls.dart';
import 'package:groceries/features/home/data/datasource/category_remote_datasource.dart';
import 'package:groceries/features/home/data/model/category_model.dart';
import 'package:groceries/features/home/data/model/category_product_response.dart';
import 'package:groceries/features/home/domain/entities/category_entities.dart';
import 'package:groceries/features/home/domain/entities/category_product_response.dart';
import 'package:logger/logger.dart';

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final DioClient dioClient;
  final Logger _logger = Logger();

  CategoryRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<Category>> fetchAllCategories() async {
    _logger.i('Fetching all categories.');
    try {
      final response = await dioClient.get(Urls.categories);
      if (response.data != null && response.data['data'] is List) {
        final data = response.data['data'] as List<dynamic>;
        _logger.i('Categories fetched successfully. Count: ${data.length}');
        return data.map((json) => CategoryModel.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        _logger.w('Categories data is not in the expected format: ${response.data}');
        return [];
      }
    } on DioException catch (e) {
      _logger.e('Dio error while fetching categories: ${e.response?.data}', error: e, stackTrace: e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _logger.e('Unexpected error while fetching categories: $e', error: e, stackTrace: stackTrace);
      throw Exception('An unexpected error occurred while fetching categories: $e');
    }
  }

  @override
  Future<CategoryWithProductsResponse> fetchCategoryWithProducts(int categoryId) async {
    _logger.i('Fetching category with products for id: $categoryId');
    try {
      final response = await dioClient.get(Urls.getCategoryUrl(categoryId));
      _logger.i('Category with products fetched successfully for id: $categoryId. Response data: ${response.data}');
      if (response.data != null && response.data is Map<String, dynamic>) {
        return CategoryResponseModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        _logger.e('Unexpected response format for category with products: ${response.data}');
        throw Exception('Failed to parse category with products');
      }
    } on DioException catch (e) {
      _logger.e('Dio error while fetching category with products: ${e.response?.data}', error: e, stackTrace: e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _logger.e('Unexpected error while fetching category with products: $e', error: e, stackTrace: stackTrace);
      throw Exception('An unexpected error occurred while fetching category with products: $e');
    }
  }
}
