import 'package:groceries/features/home/data/model/product_model.dart';
import 'package:groceries/features/home/domain/entities/product_entites.dart';
import 'package:groceries/features/home/domain/entities/product_response.dart';

import '../../domain/entities/link_entites.dart';

class ProductResponseModel extends ProductResponse {
  const ProductResponseModel({
    required super.data,
    super.currentPage,
    super.lastPage,
    super.total,
    super.path,
    super.perPage,
    super.links,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> dataMap = json['data'] is Map<String,dynamic> ? json['data'] : {};

    final List<dynamic> productListJson = dataMap['data'] as List<dynamic>? ?? [];
    final List<Product> products = productListJson
        .map((pJson) => ProductModel.fromJson(pJson as Map<String, dynamic>))
        .toList();

    final List<dynamic> linksJson = dataMap['links'] as List<dynamic>? ?? [];
    final List<Link> links = linksJson
        .map((lJson) => Link.fromJson(lJson as Map<String, dynamic>))
        .toList();

    return ProductResponseModel(
      data: products,
      currentPage: dataMap['current_page'] as int?,
      lastPage: dataMap['last_page'] as int?,
      total: dataMap['total'] as int?,
      path: dataMap['path'] as String?,
      perPage: dataMap['per_page'] as int?,
      links: links.isNotEmpty ? links : null,
    );
  }
}
