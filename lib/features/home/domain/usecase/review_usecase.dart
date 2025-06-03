import '../repository/product_repository.dart' show ProductRepository;

class SubmitReviewUseCase {
  final ProductRepository repository;

  SubmitReviewUseCase(this.repository);

  Future<void> call(int productId, String comment, double rating) {
    return repository.submitReview(productId, comment, rating);
  }
}
