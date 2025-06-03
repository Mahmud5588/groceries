import 'package:groceries/features/cart/domain/entites/cart_entites.dart';

abstract class CartRemoteDataSource {
  Future<Cart> getCart();

  Future<Cart> addItemToCart({required int productId, required int quantity});

  Future<Cart> updateCartItem({required int itemId, required int quantity});

  Future<void> removeCartItem({required int itemId});
}
