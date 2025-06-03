import 'package:groceries/features/home/domain/entities/category_product_response.dart';
import 'package:groceries/features/home/domain/repository/category_repository.dart';

class FetchCategoryWithProductsUseCase {
  final CategoryRepository repository;

  FetchCategoryWithProductsUseCase(this.repository);

  Future<CategoryWithProductsResponse> call(int categoryId) {
    return repository.fetchCategoryWithProducts(categoryId);
  }
}
