import 'package:groceries/core/network/urls.dart';
import 'package:groceries/core/network/dio_client.dart';
import 'package:groceries/features/cart/data/model/cart_model.dart';
import 'package:groceries/features/cart/domain/entites/cart_entites.dart';

import 'cart_remote_datasource.dart';

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final DioClient dioClient;

  CartRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Cart> getCart() async {
    final response = await dioClient.get(Urls.cart);
    return CartModel.fromJson(response.data['data']);
  }

  @override
  Future<Cart> addItemToCart({required int productId, required int quantity}) async {
    final response = await dioClient.post(
      Urls.cartItems,
      data: {
        'product_id': productId,
        'quantity': quantity,
      },
    );
    return CartModel.fromJson(response.data['data']);
  }

  @override
  Future<Cart> updateCartItem({required int itemId, required int quantity}) async {
    // Swagger: PUT /cart/items/{itemsId}
    final response = await dioClient.put(
      '${Urls.cartItems}/$itemId',
      data: {
        'quantity': quantity,
      },
    );
    return CartModel.fromJson(response.data['data']);
  }

  @override
  Future<void> removeCartItem({required int itemId}) async {
    // Swagger: DELETE /cart/items/{itemsId}
    await dioClient.delete('${Urls.cartItems}/$itemId'); // <--- TO'G'IRLANDI: "/" qo'shildi
  }
}