// lib/features/home/domain/entities/category_entities.dart
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String? slug;
  final String? description;
  final String? imageUrl;
  final int productsCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Category({
    required this.id,
    required this.name,
    this.slug,
    this.description,
    this.imageUrl,
    required this.productsCount,
    required this.createdAt,
    required this.updatedAt,
  });



  @override
  List<Object?> get props => [
    id,
    name,
    slug,
    description,
    imageUrl,
    productsCount,
    createdAt,
    updatedAt,
  ];
}

