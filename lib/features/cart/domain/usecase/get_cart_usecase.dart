import 'package:groceries/features/cart/domain/entites/cart_entites.dart';
import 'package:groceries/features/cart/domain/repositories/cart_repository.dart';

class GetCartUseCase{
  CartRepository cartRepository;
  GetCartUseCase(this.cartRepository);
  Future<Cart> addCart()async{
    return await cartRepository.getCart();
  }
}