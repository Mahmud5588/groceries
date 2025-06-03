
import 'package:groceries/features/home/domain/entities/product_entites.dart';
import 'package:groceries/features/home/domain/repository/product_repository.dart';

class FetchFavoritesUseCase {
  final ProductRepository repository;

  FetchFavoritesUseCase(this.repository);

  Future<List<Product>> call() {
    return repository.fetchFavorites();
  }
}
