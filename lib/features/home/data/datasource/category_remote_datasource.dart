import 'package:groceries/features/home/domain/entities/category_entities.dart';
import 'package:groceries/features/home/domain/entities/category_product_response.dart';

abstract class CategoryRemoteDataSource {
  Future<List<Category>> fetchAllCategories();
  Future<CategoryWithProductsResponse> fetchCategoryWithProducts(int categoryId);
}
