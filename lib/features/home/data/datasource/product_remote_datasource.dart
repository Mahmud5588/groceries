import 'package:groceries/features/home/data/model/product_model.dart';
import 'package:groceries/features/home/domain/entities/product_entites.dart';
import 'package:groceries/features/home/domain/entities/product_response.dart';
import 'package:groceries/features/home/domain/entities/category_entities.dart'; // Yangi entity importi

abstract class ProductRemoteDataSource {
  Future<ProductResponse> fetchProducts(Map<String, dynamic> queryParams);
  Future<bool> toggleFavorite(int productId);
  Future<List<Product>> fetchFavorites();
  Future<void> submitReview(int productId, String content, double rating);
  Future<ProductModel> fetchProduct(int productId);
}
