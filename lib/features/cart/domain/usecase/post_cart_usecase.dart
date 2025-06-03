import 'package:groceries/features/cart/domain/entites/cart_entites.dart';
import 'package:groceries/features/cart/domain/repositories/cart_repository.dart';

class UpdateCartUseCase{
  CartRepository cartRepository;
  UpdateCartUseCase(this.cartRepository);
  Future<Cart> addCart(int itemId, int quantity)async{
    return await cartRepository.updateCartItem(itemId: itemId, quantity: quantity);
  }
}