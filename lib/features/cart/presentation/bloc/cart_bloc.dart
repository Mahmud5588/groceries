import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/features/cart/domain/entites/cart_entites.dart';
import 'package:groceries/features/cart/domain/repositories/cart_repository.dart';
import 'package:groceries/features/cart/presentation/bloc/cart_state.dart';

import 'event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(CartInitial()) {
    on<GetCartEvent>(_onGetCart);
    on<AddItemToCartEvent>(_onAddItemToCart);
    on<UpdateCartItemEvent>(_onUpdateCartItem);
    on<RemoveCartItemEvent>(_onRemoveCartItem);
  }

  Cart? _getCurrentCartFromState() {
    if (state is CartLoaded) {
      return (state as CartLoaded).cart;
    } else if (state is CartLoading) {
      return (state as CartLoading).cart;
    }
    return null;
  }

  Future<void> _onGetCart(GetCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading(cart: _getCurrentCartFromState()));
    try {
      final cart = await cartRepository.getCart();
      emit(CartLoaded(cart: cart));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        emit(const CartAuthError("Sessiya muddati tugadi. Iltimos, qaytadan kiring."));
      } else {
        emit(CartError(message: e.response?.data['message']?.toString() ?? e.message ?? 'Savatchani yuklashda xatolik'));
      }
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onAddItemToCart(AddItemToCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading(cart: _getCurrentCartFromState(), processingProductId: event.productId));
    try {
      final cart = await cartRepository.addItemToCart(
        productId: event.productId,
        quantity: event.quantity,
      );
      emit(CartLoaded(cart: cart));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        emit(const CartAuthError("Sessiya muddati tugadi. Iltimos, qaytadan kiring."));
      } else {
        emit(CartError(message: e.response?.data['message']?.toString() ?? e.message ?? 'Mahsulot qo\'shishda xatolik'));
      }
      final previousCart = _getCurrentCartFromState();
      if (previousCart != null) {
        emit(CartLoaded(cart: previousCart));
      }
    } catch (e) {
      emit(CartError(message: e.toString()));
      final previousCart = _getCurrentCartFromState();
      if (previousCart != null) {
        emit(CartLoaded(cart: previousCart));
      }
    }
  }

  Future<void> _onUpdateCartItem(UpdateCartItemEvent event, Emitter<CartState> emit) async {
    emit(CartLoading(cart: _getCurrentCartFromState(), processingItemId: event.itemId));
    try {
      final cart = await cartRepository.updateCartItem(
        itemId: event.itemId,
        quantity: event.quantity,
      );
      emit(CartLoaded(cart: cart));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        emit(const CartAuthError("Sessiya muddati tugadi. Iltimos, qaytadan kiring."));
      } else {
        emit(CartError(message: e.response?.data['message']?.toString() ?? e.message ?? 'Miqdorni yangilashda xatolik'));
      }
      final previousCart = _getCurrentCartFromState();
      if (previousCart != null) {
        emit(CartLoaded(cart: previousCart));
      }
    } catch (e) {
      emit(CartError(message: e.toString()));
      final previousCart = _getCurrentCartFromState();
      if (previousCart != null) {
        emit(CartLoaded(cart: previousCart));
      }
    }
  }

  Future<void> _onRemoveCartItem(RemoveCartItemEvent event, Emitter<CartState> emit) async {
    emit(CartLoading(cart: _getCurrentCartFromState(), processingItemId: event.itemId));
    try {
      await cartRepository.removeCartItem(itemId: event.itemId);
      final cart = await cartRepository.getCart(); // Refresh the cart
      emit(CartLoaded(cart: cart));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        emit(const CartAuthError("Sessiya muddati tugadi. Iltimos, qaytadan kiring."));
      } else {
        emit(CartError(message: e.response?.data['message']?.toString() ?? e.message ?? 'Mahsulotni o\'chirishda xatolik'));
      }
      final previousCart = _getCurrentCartFromState();
      if (previousCart != null) {
        emit(CartLoaded(cart: previousCart));
      }
    } catch (e) {
      emit(CartError(message: e.toString()));
      final previousCart = _getCurrentCartFromState();
      if (previousCart != null) {
        emit(CartLoaded(cart: previousCart));
      }
    }
  }
}
