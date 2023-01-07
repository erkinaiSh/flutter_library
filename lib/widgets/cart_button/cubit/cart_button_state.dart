part of 'cart_button_cubit.dart';

class CartButtonState extends Equatable {
  final bool inCart;
  const CartButtonState(
    this.inCart,
  );
  factory CartButtonState.initial() => const CartButtonState(false);

  CartButtonState copyWith({
    bool? inCart,
  }) {
    return CartButtonState(
      inCart ?? this.inCart,
    );
  }

  @override
  List<Object?> get props => [inCart];
}
