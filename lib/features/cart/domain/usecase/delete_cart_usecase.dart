import 'dart:ffi';

import 'package:groceries/features/cart/domain/entites/cart_entites.dart';
import 'package:groceries/features/cart/domain/repositories/cart_repository.dart';

class DeleteCartUseCase{
  CartRepository cartRepository;
  DeleteCartUseCase(this.cartRepository);
  Future<void> call(int itemId)async{
    return await cartRepository.removeCartItem(itemId: itemId);
  }
}