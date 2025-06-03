import 'package:groceries/features/home/domain/repository/product_repository.dart';

abstract class AbstractToggleFavoriteUseCase {
  Future<bool> call(int productId);
}

class ToggleFavoriteUseCase implements AbstractToggleFavoriteUseCase {
  final ProductRepository repository;

  ToggleFavoriteUseCase(this.repository);

  @override
  Future<bool> call(int productId) async {
    return await repository.toggleFavorite(productId);
  }
}
