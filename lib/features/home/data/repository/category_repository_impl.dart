import 'package:groceries/features/home/data/datasource/category_remote_datasource.dart';
import 'package:groceries/features/home/domain/entities/category_entities.dart';
import 'package:groceries/features/home/domain/entities/category_product_response.dart';
import 'package:groceries/features/home/domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Category>> fetchAllCategories() {
    return remoteDataSource.fetchAllCategories();
  }

  @override
  Future<CategoryWithProductsResponse> fetchCategoryWithProducts(int categoryId) {
    return remoteDataSource.fetchCategoryWithProducts(categoryId);
  }
}
