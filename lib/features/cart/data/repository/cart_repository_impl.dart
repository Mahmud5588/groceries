import 'package:groceries/features/cart/data/datasource/cart_remote_datasource.dart';
import 'package:groceries/features/cart/domain/entites/cart_entites.dart';
import 'package:groceries/features/cart/domain/repositories/cart_repository.dart';


class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Cart> getCart() async {
    return await remoteDataSource.getCart();
  }

  @override
  Future<Cart> addItemToCart({required int productId, required int quantity}) async {
    return await remoteDataSource.addItemToCart(productId: productId, quantity: quantity);
  }

  @override
  Future<Cart> updateCartItem({required int itemId, required int quantity}) async {
    return await remoteDataSource.updateCartItem(itemId: itemId, quantity: quantity);
  }

  @override
  Future<void> removeCartItem({required int itemId}) async {
    return await remoteDataSource.removeCartItem(itemId: itemId);
  }
}
