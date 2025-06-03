import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/core/route/route_names.dart';
import 'package:groceries/features/cart/data/model/cart_item_model.dart';
import 'package:groceries/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:groceries/features/cart/presentation/bloc/cart_state.dart';
import 'package:groceries/features/cart/presentation/bloc/event.dart'
    as cart_event;
import 'package:groceries/features/home/data/model/product_model.dart';
import 'package:groceries/features/home/domain/entities/product_entites.dart';
import 'package:groceries/features/home/presentation/bloc/event.dart'
    as product_event;
import 'package:groceries/features/home/presentation/bloc/products/products_bloc.dart';
import 'package:groceries/features/home/presentation/bloc/products/products_state.dart';
import 'package:groceries/features/home/presentation/widget/featured.dart';
import 'package:logger/logger.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  final Logger _logger = Logger();

  String? _currentSearchTerm;
  bool? _isFeaturedFilter;
  bool? _isNewFilter;
  bool? _organicFilter;
  int? _categoryIdFilter;
  String? _sortByFilter;
  String? _sortOrderFilter;
  double? _minPriceFilter;
  double? _maxPriceFilter;

  final List<Map<String, dynamic>> _bannerItems = [
    {
      "title": "20_off_on_your_first_purchase".tr(),
      "image": "assets/images/home.png",
    },
    {
      "title": "special_offer_buy_one_get_one_free".tr(),
      "image": "assets/images/home.png",
    },
    {
      "title": "limited_time_offer_50_off".tr(),
      "image": "assets/images/home.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchInitialData();
  }

  void _fetchInitialData() {
    context.read<ProductBloc>().add(
      const product_event.FetchProductsEvent(
        page: 1,
        perPage: 10,
        forceRefresh: true,
      ),
    );
    context.read<ProductBloc>().add(product_event.FetchAllCategoriesEvent());
    context.read<ProductBloc>().add(product_event.FetchFavoritesEvent());
    context.read<CartBloc>().add(cart_event.GetCartEvent());
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final productBloc = context.read<ProductBloc>();
      final currentState = productBloc.state;
      if (currentState is ProductsLoaded && currentState.hasMore) {
        productBloc.add(
          product_event.LoadMoreProductsEvent(
            perPage: 10,
            categoryId: _categoryIdFilter,
            featured: _isFeaturedFilter,
            isNew: _isNewFilter,
            organic: _organicFilter,
            minPrice: _minPriceFilter,
            maxPrice: _maxPriceFilter,
            search: _currentSearchTerm,
            sortBy: _sortByFilter,
            sortOrder: _sortOrderFilter,
          ),
        );
      }
    }
  }

  void _applyFiltersAndFetch({int page = 1, bool forceRefresh = true}) {
    context.read<ProductBloc>().add(
      product_event.ResetFiltersAndFetchProductsEvent(
        categoryId: _categoryIdFilter,
        featured: _isFeaturedFilter,
        isNew: _isNewFilter,
        organic: _organicFilter,
        minPrice: _minPriceFilter,
        maxPrice: _maxPriceFilter,
        search: _currentSearchTerm,
        sortBy: _sortByFilter,
        sortOrder: _sortOrderFilter,
        page: page,
        perPage: 10,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onAddToCart(Product product) {
    context.read<CartBloc>().add(
      cart_event.AddItemToCartEvent(productId: product.id, quantity: 1),
    );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${product.name} ${'added_to_cart'.tr()}')),
      );
    }
  }

  void _incrementCartItem(Product product, List<CartItemModel> cartItems) {
    final existingItem = cartItems.firstWhere(
      (item) => item.productId == product.id,
      orElse: () => CartItemModel.empty(),
    );
    if (existingItem.id != 0) {
      context.read<CartBloc>().add(
        cart_event.UpdateCartItemEvent(
          itemId: existingItem.id,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _onAddToCart(product);
    }
  }

  void _decrementCartItem(Product product, List<CartItemModel> cartItems) {
    final existingItem = cartItems.firstWhere(
      (item) => item.productId == product.id,
      orElse: () => CartItemModel.empty(),
    );
    if (existingItem.id != 0) {
      if (existingItem.quantity > 1) {
        context.read<CartBloc>().add(
          cart_event.UpdateCartItemEvent(
            itemId: existingItem.id,
            quantity: existingItem.quantity - 1,
          ),
        );
      } else {
        context.read<CartBloc>().add(
          cart_event.RemoveCartItemEvent(itemId: existingItem.id),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            right: 16,
            bottom: 10,
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(milliseconds: 700), () {
                setState(() {
                  _currentSearchTerm =
                      value.trim().isNotEmpty ? value.trim() : null;
                  _categoryIdFilter = null;
                });
                _applyFiltersAndFetch(forceRefresh: true);
              });
            },
            decoration: InputDecoration(
              hintText: "searchKeyword".tr(),
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: theme.hintColor,
              ),
              prefixIcon: Icon(Icons.search, color: theme.hintColor),
              suffixIcon: IconButton(
                icon: Icon(Icons.tune, color: theme.hintColor),
                onPressed: () async {
                  final Map<String, dynamic>? filters =
                      await Navigator.pushNamed(context, RouteNames.filterPage)
                          as Map<String, dynamic>?;
                  if (filters != null) {
                    setState(() {
                      _isFeaturedFilter = filters['featured'] as bool?;
                      _isNewFilter = filters['isNew'] as bool?;
                      _organicFilter = filters['organic'] as bool?;
                      _sortByFilter = filters['sortBy'] as String?;
                      _sortOrderFilter = filters['sortOrder'] as String?;
                      _minPriceFilter = filters['minPrice'] as double?;
                      _maxPriceFilter = filters['maxPrice'] as double?;
                      _searchController.clear();
                      _currentSearchTerm = null;
                      _categoryIdFilter = null;
                    });
                    _applyFiltersAndFetch(forceRefresh: true);
                  }
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
              ),
              filled: true,
              fillColor: theme.cardColor,
              contentPadding: EdgeInsets.symmetric(
                vertical: AppResponsive.height(1.5),
                horizontal: AppResponsive.width(4),
              ),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: Container(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _fetchInitialData();
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppResponsive.height(1)),
                SizedBox(
                  height: AppResponsive.height(22),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _bannerItems.length,
                    itemBuilder: (context, index) {
                      final item = _bannerItems[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: AppResponsive.screenWidth - 32,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(item['image'], fit: BoxFit.cover),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.0),
                                      Colors.black.withOpacity(0.4),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    item['title'],
                                    style: theme.textTheme.headlineSmall
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: AppResponsive.width(4.5),
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: AppResponsive.height(2.5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "category".tr(),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteNames.categoryPage);
                      },
                      child: Text(
                        "see_all".tr(),
                        style: TextStyle(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppResponsive.height(1)),
                SizedBox(
                  height: AppResponsive.height(15),
                  child: BlocBuilder<ProductBloc, ProductState>(
                    buildWhen:
                        (previous, current) =>
                            current is CategoriesLoading ||
                            current is CategoriesLoaded ||
                            (current is ProductError &&
                                current.message.contains("Kategoriyalarni")),
                    builder: (context, state) {
                      _logger.d("Category BlocBuilder state: $state");
                      if (state is CategoriesLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CategoriesLoaded) {
                        if (state.categories.isEmpty) {
                          return Center(
                            child: Text("no_categories_found".tr()),
                          );
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            final category = state.categories[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _categoryIdFilter = category.id;
                                  _currentSearchTerm = null;
                                  _searchController.clear();
                                });
                                _applyFiltersAndFetch(forceRefresh: true);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: AppResponsive.width(3.5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: AppResponsive.width(8),
                                      backgroundColor: theme.cardColor
                                          .withOpacity(0.8),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child:
                                            (category.imageUrl != null &&
                                                    category
                                                        .imageUrl!
                                                        .isNotEmpty)
                                                ? Image.network(
                                                  category.imageUrl!,
                                                  fit: BoxFit.contain,
                                                  errorBuilder:
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) => Icon(
                                                        Icons.category_outlined,
                                                        size:
                                                            AppResponsive.width(
                                                              6,
                                                            ),
                                                        color: theme
                                                            .iconTheme
                                                            .color
                                                            ?.withOpacity(0.6),
                                                      ),
                                                )
                                                : Icon(
                                                  Icons.category_outlined,
                                                  size: AppResponsive.width(6),
                                                  color: theme.iconTheme.color
                                                      ?.withOpacity(0.6),
                                                ),
                                      ),
                                    ),
                                    SizedBox(height: AppResponsive.height(0.8)),
                                    SizedBox(
                                      width: AppResponsive.width(18),
                                      child: Text(
                                        category.name.tr(),
                                        // Bu yerda tarjima qilinadi
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is ProductError &&
                          state.message.contains("Kategoriyalarni")) {
                        return Center(
                          child: Text("failed_to_load_categories".tr()),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                SizedBox(height: AppResponsive.height(2.5)),
                Text(
                  "featuredProducts".tr(),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppResponsive.height(1.5)),
                BlocConsumer<ProductBloc, ProductState>(
                  listener: (context, productState) {
                    _logger.d(
                      "ProductList BlocConsumer listener state: $productState",
                    );
                    if (productState is AuthenticationError) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(productState.message.tr())),
                        );
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          RouteNames.signIn,
                          (route) => false,
                        );
                      }
                    } else if (productState is ProductError &&
                        !productState.message.contains("Kategoriyalarni")) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(productState.message.tr())),
                        );
                      }
                    }
                  },
                  buildWhen:
                      (previous, current) =>
                          current is ProductLoading ||
                          current is ProductsLoaded ||
                          (current is ProductError &&
                              !current.message.contains("Kategoriyalarni")),
                  builder: (context, productState) {
                    _logger.d(
                      "ProductList BlocConsumer builder state: $productState",
                    );
                    List<Product> productsData = [];
                    bool isLoadingMore = false;
                    bool hasMoreData = true; // Default qiymat

                    if (productState is ProductsLoaded) {
                      productsData = productState.products.data;
                      hasMoreData = productState.hasMore;
                    } else if (productState is ProductLoading &&
                        productState.previousProducts != null) {
                      productsData = productState.previousProducts!.data;
                      isLoadingMore = true;
                      // Agar oldingi holat ProductsLoaded bo'lsa, uning hasMore qiymatini olamiz
                      final prevState = context.read<ProductBloc>().state;
                      if (prevState is ProductsLoaded) {
                        hasMoreData = prevState.hasMore;
                      }
                    }

                    if (productState is ProductLoading &&
                        productsData.isEmpty &&
                        productState.processingProductId == null) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (productsData.isEmpty &&
                        productState is! ProductLoading) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppResponsive.height(5),
                          ),
                          child: Text(
                            "no_products_found".tr(),
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                      );
                    }

                    return BlocBuilder<CartBloc, CartState>(
                      builder: (context, cartState) {
                        List<CartItemModel> cartItems = [];
                        if (cartState is CartLoaded) {
                          if (cartState.cart.items.every(
                            (item) => item is CartItemModel,
                          )) {
                            cartItems =
                                cartState.cart.items.cast<CartItemModel>();
                          } else {
                            _logger.w(
                              "CartLoaded items are not all CartItemModel. Attempting conversion.",
                            );
                            cartItems =
                                cartState.cart.items.map((e) {
                                  if (e is CartItemModel) return e;
                                  return CartItemModel(
                                    id: e.id,
                                    cartId: e.cartId,
                                    productId: e.productId,
                                    quantity: e.quantity,
                                    price: e.price,
                                    product:
                                        e.product != null
                                            ? ProductModel.empty().copyWith(
                                              id: e.product!.id,
                                              name: e.product!.name,
                                              price: e.product!.price,
                                              unit: e.product!.unit,
                                              image: e.product!.image,
                                              categoryId: e.product!.categoryId,
                                            )
                                            : null,
                                  );
                                }).toList();
                          }
                        } else if (cartState is CartLoading &&
                            cartState.cart != null) {
                          if (cartState.cart!.items.every(
                            (item) => item is CartItemModel,
                          )) {
                            cartItems =
                                cartState.cart!.items.cast<CartItemModel>();
                          } else {
                            _logger.w(
                              "CartLoading items are not all CartItemModel. Attempting conversion.",
                            );
                            cartItems =
                                cartState.cart!.items.map((e) {
                                  if (e is CartItemModel) return e;
                                  return CartItemModel(
                                    id: e.id,
                                    cartId: e.cartId,
                                    productId: e.productId,
                                    quantity: e.quantity,
                                    price: e.price,
                                    product:
                                        e.product != null
                                            ? ProductModel.empty().copyWith(
                                              id: e.product!.id,
                                              name: e.product!.name,
                                              price: e.product!.price,
                                              unit: e.product!.unit,
                                              image: e.product!.image,
                                              categoryId: e.product!.categoryId,
                                            )
                                            : null,
                                  );
                                }).toList();
                          }
                        }

                        return Column(
                          children: [
                            GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: AppResponsive.height(2),
                                    crossAxisSpacing: AppResponsive.width(4),
                                    childAspectRatio: 0.60,
                                  ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: productsData.length,
                              itemBuilder: (context, index) {
                                final product = productsData[index];
                                final cartItem = cartItems.firstWhere(
                                  (item) => item.productId == product.id,
                                  orElse:
                                      () =>
                                          CartItemModel.empty(), // Xatolik shu yerda edi, tuzatildi
                                );
                                final quantityInCart =
                                    cartItem.id == 0 ? 0 : cartItem.quantity;
                                bool isProcessingFavorite =
                                    (productState is ProductLoading &&
                                        productState.processingProductId ==
                                            product.id);

                                return FeaturedProductCard(
                                  product: product,
                                  cartQuantity: quantityInCart,
                                  onFavoriteToggle:
                                      isProcessingFavorite
                                          ? null
                                          : () {
                                            context.read<ProductBloc>().add(
                                              product_event.ToggleFavoriteEvent(
                                                product.id,
                                              ),
                                            );
                                          },
                                  onAddToCart: () => _onAddToCart(product),
                                  onIncrement:
                                      (p) => _incrementCartItem(p, cartItems),
                                  onDecrement:
                                      (p) => _decrementCartItem(p, cartItems),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.productPage,
                                      arguments:
                                          product, // Pass the full product object instead of just the ID
                                    );
                                  },
                                );
                              },
                            ),
                            if (isLoadingMore && hasMoreData)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            if (!hasMoreData && productsData.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                ),
                                child: Text(
                                  "all_products_loaded".tr(),
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                          ],
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: AppResponsive.height(3)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
