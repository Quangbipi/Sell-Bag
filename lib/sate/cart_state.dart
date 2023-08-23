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


  @override
  // TODO: implement props
  List<Object?> get props => [];

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
  @override
  // TODO: implement props
  List<Object?> get props => [cartStatus];
}

class ChangStatusCartFailed extends CartState{
  String errString;

  ChangStatusCartFailed(this.errString);
  @override
  // TODO: implement props
  List<Object?> get props => [errString];
}

class DeleteCartSuccess extends CartState{

  DeleteCartSuccess();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DeleteCartFailed extends CartState{
  String errString;

  DeleteCartFailed(this.errString);
  @override
  // TODO: implement props
  List<Object?> get props => [errString];
}