import 'package:groceries/features/cart/domain/entites/cart_entites.dart';
import 'package:groceries/features/cart/domain/repositories/cart_repository.dart';

class AddCartUseCase{
  CartRepository cartRepository;
  AddCartUseCase(this.cartRepository);
  Future<Cart> call(int productId, int quantity)async{
    return await cartRepository.addItemToCart(productId: productId, quantity: quantity);
  }
}