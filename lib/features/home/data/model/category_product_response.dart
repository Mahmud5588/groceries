import 'package:groceries/features/home/data/model/category_model.dart';
import 'package:groceries/features/home/data/model/product_response_model.dart';
import 'package:groceries/features/home/domain/entities/category_entities.dart';
import 'package:groceries/features/home/domain/entities/category_product_response.dart';

class CategoryResponseModel extends CategoryWithProductsResponse{
  CategoryResponseModel({required super.message, required super.category, required super.products});
  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      CategoryResponseModel(
        message: json['message'],
        category: CategoryModel.fromJson(json['category']),
        products: ProductResponseModel.fromJson(json['products']),
      );
}