
import 'package:equatable/equatable.dart';

import 'link_entites.dart';
import 'product_entites.dart';

class ProductResponse extends Equatable {
  final List<Product> data;
  final int? currentPage;
  final int? lastPage;
  final int? total;
  final String? path;
  final int? perPage;
  final List<Link>? links;

  const ProductResponse({
    required this.data,
    this.currentPage,
    this.lastPage,
    this.total,
    this.path,
    this.perPage,
    this.links,
  });

  ProductResponse copyWith({
    List<Product>? data,
    int? currentPage,
    int? lastPage,
    int? total,
    String? path,
    int? perPage,
    List<Link>? links,
  }) {
    return ProductResponse(
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      total: total ?? this.total,
      path: path ?? this.path,
      perPage: perPage ?? this.perPage,
      links: links ?? this.links,
    );
  }

  @override
  List<Object?> get props => [data, currentPage, lastPage, total, path, perPage, links];
}
