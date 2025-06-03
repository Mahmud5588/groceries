import 'package:groceries/features/home/domain/entities/category_entities.dart';
import 'package:groceries/features/home/domain/repository/category_repository.dart';

class FetchAllCategoriesUseCase {
  final CategoryRepository repository;

  FetchAllCategoriesUseCase(this.repository);

  Future<List<Category>> call() {
    return repository.fetchAllCategories();
  }
}
