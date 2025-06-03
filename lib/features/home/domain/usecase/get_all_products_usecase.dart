import 'package:groceries/features/home/domain/entities/product_response.dart';
import 'package:groceries/features/home/domain/repository/product_repository.dart';

class FetchProductsUseCase {
  final ProductRepository repository;

  FetchProductsUseCase(this.repository);

  Future<ProductResponse> call({
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
    return repository.fetchProducts(
      categoryId: categoryId,
      featured: featured,
      isNew: isNew,
      organic: organic,
      minPrice: minPrice,
      maxPrice: maxPrice,
      search: search,
      sortBy: sortBy,
      sortOrder: sortOrder,
      page: page,
      perPage: perPage,
    );
  }
}
