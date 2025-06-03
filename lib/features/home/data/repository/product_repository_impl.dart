import 'package:groceries/features/home/data/datasource/product_remote_datasource.dart';
import 'package:groceries/features/home/domain/entities/category_entities.dart';
import 'package:groceries/features/home/domain/entities/product_entites.dart';
import 'package:groceries/features/home/domain/entities/product_response.dart';
import 'package:groceries/features/home/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
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
  }) {
    final queryParams = <String, dynamic>{
      if (categoryId != null) 'category_id': categoryId,
      if (featured != null) 'featured': featured,
      if (isNew != null) 'new': isNew, // Backend 'new' deb qabul qiladi
      if (organic != null) 'organic': organic,
      if (minPrice != null) 'min_price': minPrice,
      if (maxPrice != null) 'max_price': maxPrice,
      if (search != null && search.isNotEmpty) 'search': search,
      if (sortBy != null) 'sort_by': sortBy,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (page != null) 'page': page,
      if (perPage != null) 'per_page': perPage,
    };
    return remoteDataSource.fetchProducts(queryParams);
  }

  @override
  Future<Product> fetchProduct(int productId) {
    return remoteDataSource.fetchProduct(productId);
  }

  @override
  Future<bool> toggleFavorite(int productId) {
    return remoteDataSource.toggleFavorite(productId);
  }

  @override
  Future<List<Product>> fetchFavorites() {
    return remoteDataSource.fetchFavorites();
  }

  @override
  Future<void> submitReview(int productId, String comment, double rating) {
    return remoteDataSource.submitReview(productId, comment, rating);
  }


}
