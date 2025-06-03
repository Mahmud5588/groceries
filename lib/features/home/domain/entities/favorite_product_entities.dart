import 'package:groceries/features/home/data/model/product_model.dart';
import 'package:groceries/features/home/domain/entities/product_entites.dart';

import 'link_entites.dart';

class FavoriteProductResponse {
  final int currentPage;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;
  final List<Product> data;

  FavoriteProductResponse({
    required this.currentPage,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
    required this.data,
  });

  factory FavoriteProductResponse.fromJson(Map<String, dynamic> json) =>
      FavoriteProductResponse(
        currentPage: json['current_page'],
        firstPageUrl: json['first_page_url'],
        from: json['from'],
        lastPage: json['last_page'],
        lastPageUrl: json['last_page_url'],
        links: List<Link>.from(json['links'].map((x) => Link.fromJson(x))),
        nextPageUrl: json['next_page_url'],
        path: json['path'],
        perPage: json['per_page'],
        prevPageUrl: json['prev_page_url'],
        to: json['to'],
        total: json['total'],
        data: List<ProductModel>.from(json['data'].map((x) => ProductModel.fromJson(x))),
      );
}
