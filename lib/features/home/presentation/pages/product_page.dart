import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/home/domain/entities/product_entites.dart';
import 'package:groceries/features/home/presentation/bloc/event.dart';
import 'package:groceries/features/home/presentation/bloc/products/products_bloc.dart';
import 'package:groceries/features/home/presentation/bloc/products/products_state.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _quantity = 1;
  double _userRating = 0.0;
  int? _productId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Get the product ID from route arguments
    final Object? args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && args is int) {
      _productId = args;
      // Fetch product details when we have the ID
      context.read<ProductBloc>().add(FetchProductDetailsEvent(_productId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    if (_productId == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('error'.tr()),
          backgroundColor: theme.appBarTheme.backgroundColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Text(
            'product_information_not_found'.tr(),
            style: theme.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductError || state is ProductDetailsError) {
            final message = state is ProductError ? state.message : (state as ProductDetailsError).message;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $message')),
            );
          } else if (state is ReviewSubmitted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('review_submitted_successfully'.tr())),
            );
          }
        },
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductDetailsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('failed_to_load_product'.tr()),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProductBloc>().add(FetchProductDetailsEvent(_productId!));
                    },
                    child: Text('retry'.tr()),
                  ),
                ],
              ),
            );
          }

          if (state is! ProductDetailsLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final Product product = state.product;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: appHeight(35),
                  child: Center(
                    child: Image.asset(
                      product.image.isNotEmpty ? product.image : 'assets/images/peach.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: appWidth(5),
                    vertical: appHeight(2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: AppTextStyle.heading.copyWith(
                              color: theme.primaryColor,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              (product.isFavorite ?? false) ? Icons.favorite : Icons.favorite_border,
                              color: (product.isFavorite ?? false) ? Colors.red : theme.hintColor,
                            ),
                            onPressed: () {
                              context.read<ProductBloc>().add(ToggleFavoriteEvent(product.id));
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: appHeight(1)),
                      Text(
                        product.name,
                        style: theme.textTheme.headlineMedium,
                      ),
                      SizedBox(height: appHeight(1)),
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            double productRating = product.averageRating ?? 0.0;
                            if (index < productRating.floor()) {
                              return Icon(Icons.star, color: Colors.amber, size: appWidth(4));
                            } else if (index < productRating) {
                              return Icon(Icons.star_half, color: Colors.amber, size: appWidth(4));
                            } else {
                              return Icon(Icons.star_border, color: Colors.amber, size: appWidth(4));
                            }
                          }),
                          SizedBox(width: appWidth(2)),
                          Text(
                            (product.averageRating ?? 0.0).toStringAsFixed(1),
                            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: appWidth(2)),
                          Text(
                            '(${(product.reviewsCount ?? 0)} reviews)',
                            style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                          ),
                        ],
                      ),
                      SizedBox(height: appHeight(2)),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: product.name?.isNotEmpty == true ? product.name : 'no_description_available'.tr(),
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: appHeight(3)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quantity',
                            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: theme.dividerColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove, color: theme.hintColor),
                                  onPressed: () {
                                    setState(() {
                                      if (_quantity > 1) _quantity--;
                                    });
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: appWidth(4)),
                                  child: Text(
                                    _quantity.toString(),
                                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add, color: theme.primaryColor),
                                  onPressed: () {
                                    setState(() {
                                      _quantity++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: appHeight(3)),
                      SizedBox(
                        width: double.infinity,
                        height: appHeight(7),
                        child: ButtonWidget(
                          text: 'write_a_review'.tr(),
                          onPressed: () async {
                            await _showReviewDialog(context, product.id);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(appWidth(5)),
        child: SizedBox(
          height: appHeight(7),
          child: ButtonWidget(
            text: 'Add to cart',
            onPressed: () {
              // Add to cart logic here
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showReviewDialog(BuildContext context, int productId) async {
    String? reviewContent;
    double tempRating = _userRating;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateInDialog) {
            return AlertDialog(
              title: Text('write_a_review'.tr()),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {
                      reviewContent = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'your_review_content'.tr(),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: appHeight(2)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < tempRating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                        ),
                        onPressed: () {
                          setStateInDialog(() {
                            tempRating = (index + 1).toDouble();
                          });
                        },
                      );
                    }),
                  ),
                  Text('${tempRating.toInt()} stars'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _userRating = 0.0;
                    });
                  },
                  child: Text('cancel'.tr()),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (reviewContent != null && reviewContent!.isNotEmpty && tempRating > 0) {
                      context.read<ProductBloc>().add(
                        SubmitReviewEvent(
                          productId: productId,
                          rating: tempRating, comment: reviewContent!,
                        ),
                      );
                      Navigator.pop(context);
                      setState(() {
                        _userRating = 0.0;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('please_enter_review_and_rating'.tr())),
                      );
                    }
                  },
                  child: Text('submit'.tr()),
                ),
              ],
            );
          },
        );
      },
    );
  }
}