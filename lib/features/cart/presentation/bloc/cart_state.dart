import 'package:equatable/equatable.dart';
import 'package:groceries/features/cart/domain/entites/cart_entites.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {
  final Cart? cart;
  final int? processingItemId; // Qaysi item o'zgaryapti (update/remove)
  final int? processingProductId; // Qaysi product qo'shilyapti

  const CartLoading({this.cart, this.processingItemId, this.processingProductId});

  @override
  List<Object?> get props => [cart, processingItemId, processingProductId];
}

class CartLoaded extends CartState {
  final Cart cart;

  const CartLoaded({required this.cart});

  @override
  List<Object?> get props => [cart];
}

class CartError extends CartState {
  final String message;

  const CartError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CartAuthError extends CartState {
  final String message;
  const CartAuthError(this.message);

  @override
  List<Object?> get props => [message];
}
