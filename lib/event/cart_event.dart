import 'package:equatable/equatable.dart';
import 'package:flutter_login/models/cart.dart';
import 'package:flutter_login/models/product.dart';

abstract class CartEvent extends Equatable{

}

class AddToCartEvent extends CartEvent{
  final int userId;
  final int productId;
  final int productNumber;


  AddToCartEvent({
    required this.userId,
    required this.productId,
    required this.productNumber,

  });
  @override
  // TODO: implement props
  List<Object?> get props => [userId, productId, productNumber];

}

class GetCartEvent extends CartEvent{

  final int userId;
  GetCartEvent(this.userId);

  @override
  // TODO: implement props
  List<Object?> get props => [userId];

}

class ChangeCartStatusEvent extends CartEvent{
  int id;
  String cartStatus;
  ChangeCartStatusEvent(this.id,this.cartStatus);

  @override
  // TODO: implement props
  List<Object?> get props => [id,cartStatus];

}