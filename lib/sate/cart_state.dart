import 'package:equatable/equatable.dart';
import 'package:flutter_login/models/cart.dart';

enum GetCartStatus{
  loading,
  failed,
  success
}


enum AddCartStatus{
  loading,
  failed,
  success
}

enum ChangeStatusCart{
  failed,
  success,
}

class CartState extends Equatable{

  // final GetCartStatus getCartStatus;
  // final AddCartStatus addCartStatus;
  // final ChangeStatusCart changeStatusCart;
  // final String? errString;
  // final List<Cart>? cartList;
  // CartState({
  //   this.getCartStatus = GetCartStatus.failed,
  //   this.addCartStatus = AddCartStatus.failed,
  //   this.changeStatusCart = ChangeStatusCart.failed,
  //   this.errString,
  //   this.cartList
  // });
  @override
  // TODO: implement props
  List<Object?> get props => [];

  // CartState copyWith({
  //   GetCartStatus? getCartStatus,
  //   AddCartStatus? addCartStatus,
  //   ChangeStatusCart? changeStatusCart,
  //   String? errString,
  //   List<Cart>? cartList
  // }){
  //   return CartState(
  //     getCartStatus: getCartStatus ?? this.getCartStatus,
  //     addCartStatus: addCartStatus ?? this.addCartStatus,
  //     changeStatusCart: changeStatusCart ?? this.changeStatusCart,
  //     errString: errString ?? this.errString,
  //     cartList: cartList ?? this.cartList,
  //   );
  // }
}

class AddToCartLoading extends CartState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class AddToCartSuccess extends CartState{


  @override
  List<Object?> get props => [];

}

class AddToCartFailed extends CartState{
  final String errorMess;
  AddToCartFailed(this.errorMess);
  @override
  // TODO: implement props
  List<Object?> get props => [errorMess];
}

class GetCartLoading extends CartState{

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class GetCartSuccess extends CartState{
  List<Cart> cartList;
  GetCartSuccess(this.cartList);
  @override
  // TODO: implement props
  List<Object?> get props => [cartList];

}

class GetCartFailed extends CartState{
  final String errorMess;
  GetCartFailed(this.errorMess);
  @override
  // TODO: implement props
  List<Object?> get props => [errorMess];

}

class ChangStatusCartSuccess extends CartState{
  final CartStatus cartStatus;
  ChangStatusCartSuccess(this.cartStatus);
}

class ChangStatusCartFailed extends CartState{
  String errString;

  ChangStatusCartFailed(this.errString);
}