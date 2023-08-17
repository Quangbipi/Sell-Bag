import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_login/respository/popular_product_repository.dart';
import 'package:flutter_login/services/local_popular_product_service.dart';


import '../event/popular_product_event.dart';
import '../sate/popular_product_state.dart';

class PopularProductBloc extends Bloc<PopularProductEvent, PopularProductState>{
  final PopularProductRepository _popularProductRepository;
  final LocalPopularProductService _localPopularProductService = LocalPopularProductService();
  PopularProductBloc(this._popularProductRepository): super(PopularProductLoading()){
    on<LoadPopularProductEvent>(_handlerLoadPopularProductEvent);
  }


  FutureOr<void> _handlerLoadPopularProductEvent(
      LoadPopularProductEvent event,
      Emitter<PopularProductState> emit) async {
    emit(PopularProductLoading());
    await _localPopularProductService.init();
    try {
      final productList = await _popularProductRepository.getProduct();
      emit(PopularProductLoaded(productList ?? []));
      if(productList == null){
        var db = _localPopularProductService.getPopularProducts();

        emit(PopularProductLoaded(db));
      }
    }catch(e){
      emit(ErrorPopularProductLoaded(e.toString()));
    }
  }
}