import 'package:equatable/equatable.dart';
import 'package:groceries/features/home/domain/entities/category_entities.dart';
import 'package:groceries/features/home/domain/entities/product_entites.dart';
import 'package:groceries/features/home/domain/entities/product_response.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {
  final ProductResponse? previousProducts;
  final int? processingProductId;

  const ProductLoading({this.previousProducts, this.processingProductId});

  @override
  List<Object?> get props => [previousProducts, processingProductId];
}

class ProductsLoaded extends ProductState {
  final ProductResponse products;
  final bool hasMore;

  const ProductsLoaded(this.products, {required this.hasMore});

  @override
  List<Object?> get props => [products, hasMore];
}

class ProductDetailsLoading extends ProductState {}

class ProductDetailsLoaded extends ProductState {
  final Product product;
  const ProductDetailsLoaded(this.product);
  @override
  List<Object?> get props => [product];
}

class ProductDetailsError extends ProductState {
  final String message;
  const ProductDetailsError(this.message);
  @override
  List<Object?> get props => [message];
}

class FavoritesLoading extends ProductState {}

class FavoritesLoaded extends ProductState {
  final List<Product> favorites;
  const FavoritesLoaded(this.favorites);
  @override
  List<Object?> get props => [favorites];
}

class CategoriesLoading extends ProductState {}

class CategoriesLoaded extends ProductState {
  final List<Category> categories;
  const CategoriesLoaded(this.categories);
  @override
  List<Object?> get props => [categories];
}

class ReviewSubmitted extends ProductState {}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);
  @override
  List<Object?> get props => [message];
}

class AuthenticationError extends ProductState {
  final String message;
  const AuthenticationError(this.message);
  @override
  List<Object?> get props => [message];
}
