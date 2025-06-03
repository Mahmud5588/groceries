import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/home/domain/entities/category_entities.dart';
import 'package:groceries/features/home/presentation/bloc/event.dart' as product_event;
import 'package:groceries/features/home/presentation/bloc/products/products_bloc.dart';
import 'package:groceries/features/home/presentation/bloc/products/products_state.dart';
import 'package:groceries/features/home/presentation/widget/category_widget.dart';
import 'package:logger/logger.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    final currentState = context.read<ProductBloc>().state;
    if (currentState is! CategoriesLoaded && currentState is! CategoriesLoading) {
      context.read<ProductBloc>().add(product_event.FetchAllCategoriesEvent());
    }
  }

  void _onCategoryTap(Category category) {
    _logger.i("Category tapped: ${category.name}, ID: ${category.id}");
    context.read<ProductBloc>().add(product_event.FetchProductsByCategoryEvent(category.id));
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'categories'.tr(),
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: appWidth(5),
            color: theme.appBarTheme.foregroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: theme.appBarTheme.foregroundColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        buildWhen: (previous, current) => current is CategoriesLoading || current is CategoriesLoaded || (current is ProductError && current.message.contains("Kategoriyalarni")),
        builder: (context, state) {
          _logger.d("CategoriesPage BlocBuilder state: $state");
          if (state is CategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoriesLoaded) {
            if (state.categories.isEmpty) {
              return Center(child: Text('no_categories_found'.tr()));
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: appWidth(4), vertical: appHeight(2)),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: appWidth(3),
                  mainAxisSpacing: appHeight(1.5),
                  childAspectRatio: 0.85,
                ),
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  final cardColor = Colors.accents[index % Colors.accents.length].withOpacity(0.15);

                  return CategoryItemWidget(
                    iconPath: category.imageUrl ?? '',
                    name: category.name.tr(),
                    backgroundColor: cardColor,
                    onTap: () => _onCategoryTap(category),
                  );
                },
              ),
            );
          } else if (state is ProductError && state.message.contains("Kategoriyalarni")) {
            return Center(child: Text('failed_to_load_categories'.tr()));
          }
          return const Center(child: Text("please_wait"));
        },
      ),
    );
  }
}
