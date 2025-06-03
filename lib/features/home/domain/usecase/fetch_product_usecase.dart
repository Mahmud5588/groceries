import 'package:groceries/features/home/domain/entities/product_entites.dart';
import 'package:groceries/features/home/domain/repository/product_repository.dart';

class FetchProductUseCase {
  final ProductRepository productRepository;

  FetchProductUseCase(this.productRepository);

  Future<Product> call(int productId) async {
    return await productRepository.fetchProduct(productId);
  }
}
