import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCartEvent extends CartEvent {}

class AddItemToCartEvent extends CartEvent {
  final int productId;
  final int quantity;

  const AddItemToCartEvent({required this.productId, required this.quantity});

  @override
  List<Object> get props => [productId, quantity];
}

class UpdateCartItemEvent extends CartEvent {
  final int itemId;
  final int quantity;

  const UpdateCartItemEvent({required this.itemId, required this.quantity});

  @override
  List<Object> get props => [itemId, quantity];
}

class RemoveCartItemEvent extends CartEvent {
  final int itemId;

  const RemoveCartItemEvent({required this.itemId});

  @override
  List<Object> get props => [itemId];
}
