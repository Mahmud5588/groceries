import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object?> get props => [];
}

class FetchProductsEvent extends ProductEvent {
  final int? categoryId;
  final bool? featured;
  final bool? isNew;
  final bool? organic;
  final double? minPrice;
  final double? maxPrice;
  final String? search;
  final String? sortBy;
  final String? sortOrder;
  final int? page;
  final int? perPage;
  final bool? forceRefresh;

  const FetchProductsEvent({
    this.categoryId, this.featured, this.isNew, this.organic, this.minPrice,
    this.maxPrice, this.search, this.sortBy, this.sortOrder, this.page, this.perPage,
    this.forceRefresh = false,
  });

  @override
  List<Object?> get props => [
    categoryId, featured, isNew, organic, minPrice, maxPrice, search,
    sortBy, sortOrder, page, perPage, forceRefresh,
  ];
}

class LoadMoreProductsEvent extends ProductEvent {
  final int perPage;
  final int? categoryId;
  final bool? featured;
  final bool? isNew;
  final bool? organic;
  final double? minPrice;
  final double? maxPrice;
  final String? search;
  final String? sortBy;
  final String? sortOrder;

  const LoadMoreProductsEvent({
    this.perPage = 10,
    this.categoryId,
    this.featured,
    this.isNew,
    this.organic,
    this.minPrice,
    this.maxPrice,
    this.search,
    this.sortBy,
    this.sortOrder,
  });

  @override
  List<Object?> get props => [
    perPage,
    categoryId,
    featured,
    isNew,
    organic,
    minPrice,
    maxPrice,
    search,
    sortBy,
    sortOrder,
  ];
}

// ResetFiltersAndFetchProductsEvent klassiga parametrlar qo'shildi
class ResetFiltersAndFetchProductsEvent extends ProductEvent {
  final int? categoryId;
  final bool? featured;
  final bool? isNew;
  final bool? organic;
  final double? minPrice;
  final double? maxPrice;
  final String? search;
  final String? sortBy;
  final String? sortOrder;
  final int? page;
  final int? perPage;

  const ResetFiltersAndFetchProductsEvent({
    this.categoryId,
    this.featured,
    this.isNew,
    this.organic,
    this.minPrice,
    this.maxPrice,
    this.search,
    this.sortBy,
    this.sortOrder,
    this.page,
    this.perPage,
  });

  @override
  List<Object?> get props => [
    categoryId, featured, isNew, organic, minPrice, maxPrice, search,
    sortBy, sortOrder, page, perPage,
  ];
}


class ToggleFavoriteEvent extends ProductEvent {
  final int productId;
  const ToggleFavoriteEvent(this.productId);
  @override
  List<Object?> get props => [productId];
}

class FetchFavoritesEvent extends ProductEvent {}

class SubmitReviewEvent extends ProductEvent {
  final int productId;
  final String comment;
  final double rating;
  const SubmitReviewEvent({required this.productId, required this.comment, required this.rating});
  @override
  List<Object?> get props => [productId, comment, rating];
}

class FetchAllCategoriesEvent extends ProductEvent {}

class FetchProductsByCategoryEvent extends ProductEvent {
  final int categoryId;
  const FetchProductsByCategoryEvent(this.categoryId);
  @override
  List<Object?> get props => [categoryId];
}

class FetchProductDetailsEvent extends ProductEvent {
  final int productId;
  const FetchProductDetailsEvent(this.productId);
  @override
  List<Object?> get props => [productId];
}
