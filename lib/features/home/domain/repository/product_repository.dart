import 'package:groceries/features/home/domain/entities/product_entites.dart';
import 'package:groceries/features/home/domain/entities/product_response.dart';

abstract class ProductRepository {
  Future<ProductResponse> fetchProducts({
    int? categoryId,
    bool? featured,
    bool? isNew,
    bool? organic,
    double? minPrice,
    double? maxPrice,
    String? search,
    String? sortBy,
    String? sortOrder,
    int? page,
    int? perPage,
  });

  Future<Product> fetchProduct(int productId);
  Future<bool> toggleFavorite(int productId);
  Future<List<Product>> fetchFavorites();
  Future<void> submitReview(int productId, String comment, double rating);
}
