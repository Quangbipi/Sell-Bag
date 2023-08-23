import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/event/cart_event.dart';
import 'package:flutter_login/models/cart.dart';
import 'package:flutter_login/sate/cart_state.dart';
import 'package:flutter_login/services/local_auth_service.dart';

import '../respository/cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState>{

  final CartRepository _cartRepository;
  final LocalAuthService _authService = LocalAuthService();
  CartBloc(this._cartRepository): super(CartState()){
    on<AddToCartEvent>(_handlerAddToCartEvent);
    on<GetCartEvent>(_handlerGetCartEvent);
    on<ChangeCartStatusEvent>(_handlerChangeStatus);
    on<DeleteCartEvent>(_handlerDeleteCart);
  }


  FutureOr<void> _handlerAddToCartEvent(
      AddToCartEvent event, Emitter<CartState> emit) async {
    emit(AddToCartLoading());
    try{
      var response = await _cartRepository.addToCart(
          userId: event.userId,
          productId: event.productId,
          productNumber: event.productNumber,


      );
      if(response.statusCode == 200){
        emit(AddToCartSuccess());
        //emit(state.copyWith(addCartStatus: AddCartStatus.success));
      }
    }catch(e){
      emit(AddToCartFailed(e.toString()));
      //emit(state.copyWith(addCartStatus: AddCartStatus.failed, errString: e.toString()));
    }
  }

  FutureOr<void> _handlerGetCartEvent(
      GetCartEvent event, Emitter<CartState> emit) async {
    try{

      final cartList = await _cartRepository.getCart(userId: event.userId);
      print(cartList.toString());
      emit(GetCartSuccess(cartList));
      //emit(state.copyWith(cartList: cartList, getCartStatus: GetCartStatus.success));
    }catch(e){
      emit(GetCartFailed(e.toString()));
      //emit(state.copyWith(getCartStatus: GetCartStatus.failed, errString: e.toString()));
    }
  }

  FutureOr<void> _handlerChangeStatus(
      ChangeCartStatusEvent event, Emitter<CartState> emit) async {
    try{
      final response = await _cartRepository.ChangeCartStatus(status: event.cartStatus, id: event.id);
      if(response.statusCode == 200 ){
        //final cartList = await _cartRepository.getCart(userId: int.parse(_authService.getUser()!.id));
        // print("aaa: ${cartList.toString()})");
        //emit(state.copyWith(changeStatusCart: ChangeStatusCart.success));
        // Cart cart = Cart.fromJson(json.decode(response.body)['data']);
        // print(cart.toString());
        //emit(GetCartSuccess(cartList));
        emit(ChangStatusCartSuccess(parseCartStatus(event.cartStatus)));
      }
    }catch(e){
      print(e.toString());
      emit(ChangStatusCartFailed(e.toString()));
      //emit(state.copyWith(changeStatusCart: ChangeStatusCart.failed, errString: e.toString()));
    }
  }

  FutureOr<void> _handlerDeleteCart(
      DeleteCartEvent event, Emitter<CartState> emit) async{
    final response = await _cartRepository.DeleteCart(id: event.id);

    if(response.statusCode == 200){
      emit(DeleteCartSuccess());

    }else{
      emit(DeleteCartFailed('Lỗi'));
    }
  }
}