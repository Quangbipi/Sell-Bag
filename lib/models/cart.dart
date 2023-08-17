import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_login/models/product.dart';

List<Cart> cartList(String val) =>
    List<Cart>.from(json.decode(val)['data'].map((cart) => Cart.fromJson(cart)));
enum CartStatus{
  unpaid,
  waiting,
  paid
}


class Cart extends Equatable {
  int? id;
  final int userId;
  final int productId;
  final int productNumber;
  final Product product;
  final CartStatus cartStatus;
  Cart({
    this.id,
    required this.userId,
    required this.productId,
    required this.productNumber,
    required this.product,
    this.cartStatus = CartStatus.unpaid
  });
  @override
  // TODO: implement props
  List<Object?> get props => [id, userId, productId, productNumber, product, cartStatus];



  factory Cart.fromJson(Map<String, dynamic> data) {
      return Cart(
        id: data['id'],
        userId: data['attributes']['userId'],
        productId: data['attributes']['productId'],
        productNumber: data['attributes']['productNumber'],
        product: Product.productFromJson(data['attributes']['product']['data']),
        cartStatus: parseCartStatus(data['attributes']['cartStatus'])
      );
  }

}

CartStatus parseCartStatus(String value) {
  if (value == 'waiting') {
    return CartStatus.waiting;
  } else if (value == 'paid') {
    return CartStatus.paid;
  }else if (value == 'unpaid') {
    return CartStatus.unpaid;
  }
  throw Exception('Invalid CartStatus value: $value');
}