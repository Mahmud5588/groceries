import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/features/home/data/model/product_model.dart';
import 'package:groceries/features/home/domain/entities/category_entities.dart';
import 'package:groceries/features/home/domain/entities/product_entites.dart';
import 'package:groceries/features/home/domain/entities/product_response.dart';
import 'package:groceries/features/home/domain/repository/category_repository.dart';
import 'package:groceries/features/home/domain/repository/product_repository.dart';
import 'package:groceries/features/home/presentation/bloc/event.dart';
import 'package:groceries/features/home/presentation/bloc/products/products_state.dart';
import 'package:logger/logger.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  final CategoryRepository categoryRepository;
  final Logger _logger = Logger();
  List<Product> _allFetchedProducts = [];
  List<Product> _currentFavorites = [];
  int _currentPage = 1;
  bool _isFetching = false;
  bool _hasMoreProducts = true;


  ProductBloc({required this.productRepository, required this.categoryRepository}) : super(ProductInitial()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<FetchFavoritesEvent>(_onFetchFavorites);
    on<SubmitReviewEvent>(_onSubmitReview);
    on<FetchAllCategoriesEvent>(_onFetchAllCategories);
    on<FetchProductsByCategoryEvent>(_onFetchProductsByCategory);
    on<FetchProductDetailsEvent>(_onFetchProductDetails);
    on<ResetFiltersAndFetchProductsEvent>(_onResetFiltersAndFetchProducts);
    on<LoadMoreProductsEvent>(_onLoadMoreProducts);
  }

  ProductResponse? _getPreviousProductsResponse(ProductState currentState) {
    if (currentState is ProductsLoaded) {
      return currentState.products;
    } else if (currentState is ProductLoading && currentState.previousProducts != null) {
      return currentState.previousProducts;
    }
    return null;
  }

  List<Product> _markFavorites(List<Product> products, List<Product> favorites) {
    final favoriteIds = favorites.map((fav) => fav.id).toSet();
    return products.map((p) => p.copyWith(isFavorite: favoriteIds.contains(p.id))).toList();
  }

  Future<void> _onFetchProducts(FetchProductsEvent event, Emitter<ProductState> emit) async {
    if (_isFetching && event.page == _currentPage) return;
    _isFetching = true;

    final currentState = state;
    ProductResponse? previousProductsData = _getPreviousProductsResponse(currentState);

    bool isInitialLoadOrFilterChange = (event.page == 1) &&
        (event.search != null ||
            event.categoryId != null ||
            event.featured != null ||
            event.isNew != null ||
            event.organic != null ||
            event.forceRefresh == true
        );

    if (isInitialLoadOrFilterChange) {
      _allFetchedProducts = [];
      _currentPage = 1;
      _hasMoreProducts = true;
      emit(const ProductLoading());
    } else if (event.page! > 1 && previousProductsData != null) {
      emit(ProductLoading(previousProducts: previousProductsData));
    } else {
      emit(ProductLoading(previousProducts: previousProductsData));
    }

    try {
      final newPageProductResponse = await productRepository.fetchProducts(
        categoryId: event.categoryId,
        featured: event.featured,
        isNew: event.isNew,
        organic: event.organic,
        minPrice: event.minPrice,
        maxPrice: event.maxPrice,
        search: event.search,
        sortBy: event.sortBy,
        sortOrder: event.sortOrder,
        page: _currentPage,
        perPage: event.perPage ?? 10,
      );

      if (newPageProductResponse.data.isEmpty) {
        _hasMoreProducts = false;
      } else {
        _currentPage++;
      }

      if (isInitialLoadOrFilterChange) {
        _allFetchedProducts = newPageProductResponse.data;
      } else {
        _allFetchedProducts.addAll(newPageProductResponse.data);
      }

      List<Product> productsToEmit = _markFavorites(_allFetchedProducts, _currentFavorites);

      final finalProductResponse = newPageProductResponse.copyWith(
        data: productsToEmit,
        currentPage: _currentPage -1,
        lastPage: newPageProductResponse.lastPage,
        total: newPageProductResponse.total,
      );

      emit(ProductsLoaded(finalProductResponse, hasMore: _hasMoreProducts));
    } on DioException catch (e) {
      _logger.e("DioError in _onFetchProducts", error: e, stackTrace: e.stackTrace);
      if (e.response?.statusCode == 401) {
        emit(const AuthenticationError("Sessiya muddati tugadi. Iltimos, qaytadan kiring."));
      } else {
        emit(ProductError(e.response?.data?['message']?.toString() ?? e.message ?? 'Mahsulotlarni yuklashda noma\'lum xatolik'));
      }
    } catch (e, stackTrace) {
      _logger.e("Error in _onFetchProducts", error: e, stackTrace: stackTrace);
      emit(ProductError(e.toString()));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> _onLoadMoreProducts(LoadMoreProductsEvent event, Emitter<ProductState> emit) async {
    if (!_isFetching && _hasMoreProducts) {
      final currentState = state;
      ProductResponse? previousProductsData = _getPreviousProductsResponse(currentState);
      add(FetchProductsEvent(
        page: _currentPage,
        perPage: event.perPage,
        categoryId: event.categoryId,
        featured: event.featured,
        isNew: event.isNew,
        organic: event.organic,
        minPrice: event.minPrice,
        maxPrice: event.maxPrice,
        search: event.search,
        sortBy: event.sortBy,
        sortOrder: event.sortOrder,
      ));
    }
  }


  Future<void> _onResetFiltersAndFetchProducts(ResetFiltersAndFetchProductsEvent event, Emitter<ProductState> emit) async {
    _allFetchedProducts = [];
    _currentPage = 1;
    _hasMoreProducts = true;
    add(const FetchProductsEvent(page: 1, perPage: 10, forceRefresh: true));
  }


  Future<void> _onToggleFavorite(ToggleFavoriteEvent event, Emitter<ProductState> emit) async {
    final currentState = state;
    ProductResponse? currentProductsResponse = _getPreviousProductsResponse(currentState);
    Product? productDetails;

    if (currentState is ProductDetailsLoaded) {
      productDetails = currentState.product;
    }

    // Optimistic update for product list
    if (currentProductsResponse != null) {
      final optimisticProducts = currentProductsResponse.data.map((p) {
        if (p.id == event.productId) {
          return p.copyWith(isFavorite: !(p.isFavorite ?? false));
        }
        return p;
      }).toList();
      emit(ProductsLoaded(currentProductsResponse.copyWith(data: _markFavorites(optimisticProducts, _currentFavorites)), hasMore: _hasMoreProducts));
    }
    // Optimistic update for product details
    else if (productDetails != null && productDetails.id == event.productId) {
      emit(ProductDetailsLoaded(productDetails.copyWith(isFavorite: !(productDetails.isFavorite ?? false ))));
    }


    try {
      final isNowFavorite = await productRepository.toggleFavorite(event.productId);
      // Update favorites list internally
      if (isNowFavorite) {
        final productToAdd = _allFetchedProducts.firstWhere(
                (p) => p.id == event.productId,
            orElse: () => ProductModel.empty()
        );        if (productToAdd.id != 0 && !_currentFavorites.any((fav) => fav.id == event.productId)) {
          _currentFavorites.add(productToAdd.copyWith(isFavorite: true));
        }
      } else {
        _currentFavorites.removeWhere((fav) => fav.id == event.productId);
      }

      // Update product list state with actual server response
      if (currentProductsResponse != null) {
        final updatedProducts = currentProductsResponse.data.map((p) {
          if (p.id == event.productId) {
            return p.copyWith(isFavorite: isNowFavorite);
          }
          return p;
        }).toList();
        _allFetchedProducts = _allFetchedProducts.map((p) {
          if (p.id == event.productId) {
            return p.copyWith(isFavorite: isNowFavorite);
          }
          return p;
        }).toList();
        emit(ProductsLoaded(currentProductsResponse.copyWith(data: _markFavorites(updatedProducts, _currentFavorites)), hasMore: _hasMoreProducts));
      }
      // Update product details state
      else if (productDetails != null && productDetails.id == event.productId) {
        emit(ProductDetailsLoaded(productDetails.copyWith(isFavorite: isNowFavorite)));
      }
      // If no prior state, or to refresh, fetch all products
      else {
        add(const FetchProductsEvent(page: 1, perPage: 10, forceRefresh: true));
      }
      // Refresh favorites list explicitly if needed
      add(FetchFavoritesEvent());


    } on DioException catch (e) {
      _logger.e("DioError in _onToggleFavorite", error: e, stackTrace: e.stackTrace);
      if (currentProductsResponse != null) { // Revert optimistic update on error
        emit(ProductsLoaded(currentProductsResponse, hasMore: _hasMoreProducts));
      } else if (productDetails != null) {
        emit(ProductDetailsLoaded(productDetails));
      }
      if (e.response?.statusCode == 401) {
        emit(const AuthenticationError("Sessiya muddati tugadi. Iltimos, qaytadan kiring."));
      } else {
        emit(ProductError(e.response?.data?['message']?.toString() ?? e.message ?? 'Amalni bajarishda xatolik yuz berdi'));
      }
    } catch (e, stackTrace) {
      _logger.e("Error in _onToggleFavorite", error: e, stackTrace: stackTrace);
      if (currentProductsResponse != null) { // Revert optimistic update on error
        emit(ProductsLoaded(currentProductsResponse, hasMore: _hasMoreProducts));
      } else if (productDetails != null) {
        emit(ProductDetailsLoaded(productDetails));
      }
      emit(ProductError(e.toString()));
    }
  }


  Future<void> _onFetchProductDetails(FetchProductDetailsEvent event, Emitter<ProductState> emit) async {
    emit(ProductDetailsLoading());
    try {
      Product product = await productRepository.fetchProduct(event.productId);
      final isFavorite = _currentFavorites.any((fav) => fav.id == product.id);
      product = product.copyWith(isFavorite: isFavorite);
      emit(ProductDetailsLoaded(product));
    } on DioException catch (e) {
      _logger.e("DioError in _onFetchProductDetails", error: e, stackTrace: e.stackTrace);
      if (e.response?.statusCode == 401) {
        emit(const AuthenticationError("Sessiya muddati tugadi. Iltimos, qaytadan kiring."));
      } else {
        emit(ProductDetailsError(e.response?.data?['message']?.toString() ?? e.message ?? 'Mahsulotni yuklashda xatolik'));
      }
    } catch (e, stackTrace) {
      _logger.e("Error in _onFetchProductDetails", error: e, stackTrace: stackTrace);
      emit(ProductDetailsError(e.toString()));
    }
  }

  // product_bloc.dart
  Future<void> _onFetchFavorites(FetchFavoritesEvent event, Emitter<ProductState> emit) async {

    try {
      _currentFavorites = await productRepository.fetchFavorites();
      _logger.d("Fetched favorites from repository, count: ${_currentFavorites.length}");
      emit(FavoritesLoaded(_currentFavorites));


      if (_allFetchedProducts.isNotEmpty) {
        _allFetchedProducts = _markFavorites(_allFetchedProducts, _currentFavorites);
      }


    } on DioException catch (e) {
      _logger.e("DioError in _onFetchFavorites", error: e, stackTrace: e.stackTrace);
      if (e.response?.statusCode == 401) {
        emit(const AuthenticationError("Sessiya muddati tugadi. Iltimos, qaytadan kiring."));
      } else {
        emit(ProductError(e.response?.data?['message']?.toString() ?? e.message ?? 'Sevimlilarni yuklashda noma\'lum xatolik'));
      }
    } catch (e, stackTrace) {
      _logger.e("Error in _onFetchFavorites", error: e, stackTrace: stackTrace);
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onFetchAllCategories(FetchAllCategoriesEvent event, Emitter<ProductState> emit) async {
    emit(CategoriesLoading());
    try {
      final List<Category> categories = await categoryRepository.fetchAllCategories();
      emit(CategoriesLoaded(categories));
    } on DioException catch (e) {
      _logger.e("DioError in _onFetchAllCategories", error: e, stackTrace: e.stackTrace);
      if (e.response?.statusCode == 401) {
        emit(const AuthenticationError("Sessiya muddati tugadi. Iltimos, qaytadan kiring."));
      } else {
        emit(ProductError(e.response?.data?['message']?.toString() ?? e.message ?? 'Kategoriyalarni yuklashda xatolik'));
      }
    } catch (e, stackTrace) {
      _logger.e("Error in _onFetchAllCategories", error: e, stackTrace: stackTrace);
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onFetchProductsByCategory(FetchProductsByCategoryEvent event, Emitter<ProductState> emit) async {
    _allFetchedProducts = [];
    _currentPage = 1;
    _hasMoreProducts = true;
    add(FetchProductsEvent(categoryId: event.categoryId, page: 1, perPage: 10, forceRefresh: true));
  }

  Future<void> _onSubmitReview(SubmitReviewEvent event, Emitter<ProductState> emit) async {
    try {
      await productRepository.submitReview(event.productId, event.comment, event.rating);
      emit(ReviewSubmitted());
      add(FetchProductDetailsEvent(event.productId)); // Refresh product details to show new review
    } on DioException catch (e) {
      _logger.e("DioError in _onSubmitReview", error: e, stackTrace: e.stackTrace);
      if (e.response?.statusCode == 401) {
        emit(const AuthenticationError("Sessiya muddati tugadi. Iltimos, qaytadan kiring."));
      } else {
        emit(ProductError(e.response?.data?['message']?.toString() ?? e.message ?? 'Fikr bildirishda xatolik'));
      }
    } catch (e, stackTrace) {
      _logger.e("Error in _onSubmitReview", error: e, stackTrace: stackTrace);
      emit(ProductError(e.toString()));
    }
  }
}
