import 'package:groceries/features/home/data/model/product_response_model.dart';
import 'package:groceries/features/home/domain/entities/product_response.dart';

import 'category_entities.dart';

class CategoryWithProductsResponse {
  final String message;
  final Category category;
  final ProductResponse products;

  CategoryWithProductsResponse({
    required this.message,
    required this.category,
    required this.products,
  });


}
