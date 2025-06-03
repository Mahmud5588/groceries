import 'package:dio/dio.dart';
import 'package:groceries/core/network/dio_client.dart';
import 'package:groceries/core/network/urls.dart';
import 'package:groceries/features/home/data/datasource/product_remote_datasource.dart';
import 'package:groceries/features/home/data/model/product_model.dart';
import 'package:groceries/features/home/data/model/product_response_model.dart';
import 'package:groceries/features/home/domain/entities/product_entites.dart';
import 'package:groceries/features/home/domain/entities/product_response.dart';
import 'package:logger/logger.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioClient dioClient;
  final Logger _logger = Logger();

  ProductRemoteDataSourceImpl(this.dioClient);

  @override
  Future<ProductResponse> fetchProducts(Map<String, dynamic> queryParams) async {
    _logger.i('Fetching products with params: $queryParams');
    try {
      final response = await dioClient.get(Urls.products, queryParams: queryParams);
      _logger.i('Products fetched successfully: ${response.statusCode}');
      return ProductResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      _logger.e('Dio error while fetching products: ${e.response?.data}', error: e, stackTrace: e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _logger.e('Unexpected error while fetching products: $e', error: e, stackTrace: stackTrace);
      throw Exception('An unexpected error occurred while fetching products');
    }
  }

  @override
  Future<ProductModel> fetchProduct(int productId) async {
    _logger.i('Fetching details for product $productId.');
    try {
      final response = await dioClient.get('${Urls.products}/$productId');
      _logger.i('Product details fetched successfully for id: $productId. Response data: ${response.data}');
      if (response.data != null && response.data['data'] is Map<String, dynamic>) {
        return ProductModel.fromJson(response.data['data'] as Map<String, dynamic>);
      } else {
        _logger.e('Unexpected response format for product details: ${response.data}');
        throw Exception('Failed to parse product details');
      }
    } on DioException catch (e) {
      _logger.e('Dio error fetching product details for id $productId: ${e.response?.data}', error: e, stackTrace: e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _logger.e('Unexpected error fetching product details for id $productId: $e', error: e, stackTrace: stackTrace);
      throw Exception('An unexpected error occurred while fetching details');
    }
  }

  @override
  Future<bool> toggleFavorite(int productId) async {
    _logger.i('Toggling favorite for product $productId.');
    try {
      final response = await dioClient.post(Urls.getProductFavoriteUrl(productId));
      _logger.i('Successfully toggled favorite for product $productId. Response: ${response.data}');
      final bool isFavorited = response.data['is_favorited'] as bool? ?? false;
      return isFavorited;
    } on DioException catch (e) {
      _logger.e('Dio error while toggling favorite: ${e.response?.data}', error: e, stackTrace: e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _logger.e('Unexpected error while toggling favorite: $e', error: e, stackTrace: stackTrace);
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<List<Product>> fetchFavorites() async {
    _logger.i('Fetching favorites.');
    try {
      final response = await dioClient.get(Urls.favoriteList);
      if (response.data != null && response.data['data'] != null && response.data['data']['data'] is List) {
        final productListJson = response.data['data']['data'] as List<dynamic>;
        _logger.i('Favorites fetched successfully. Count: ${productListJson.length}');
        return productListJson.map((json) => ProductModel.fromJson(json as Map<String, dynamic>).copyWith(isFavorite: true)).toList();
      } else {
        _logger.w('Favorites data is not in the expected format: ${response.data}');
        return [];
      }
    } on DioException catch (e) {
      _logger.e('Dio error while fetching favorites: ${e.response?.data}', error: e, stackTrace: e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _logger.e('Unexpected error while fetching favorites: $e', error: e, stackTrace: stackTrace);
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<void> submitReview(int productId, String comment, double rating) async {
    _logger.i('Submitting review for product $productId. Rating: $rating');
    try {
      await dioClient.post(Urls.getProductIdReviewUrl(productId), data: {
        'comment': comment,
        'rating': rating,
      });
      _logger.i('Review for product $productId submitted successfully.');
    } on DioException catch (e) {
      _logger.e('Dio error while submitting review: ${e.response?.data}', error: e, stackTrace: e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _logger.e('Unexpected error while submitting review: $e', error: e, stackTrace: stackTrace);
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
