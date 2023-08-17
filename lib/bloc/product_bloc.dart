import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/event/product_event.dart';
import 'package:flutter_login/models/product.dart';
import 'package:flutter_login/respository/product_repository.dart';
import 'package:flutter_login/sate/product_state.dart';
import 'package:flutter_login/services/local_product_service.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState>{
  final ProductRepository _productRepository;
  final LocalProductService _localProductService = LocalProductService();
  ProductBloc(this._productRepository) : super(ProductLoading()){
   on<LoadProductEvent>(_handledLoadProductEvent);
   on<SearchProduct>(_handledSearchCompleteProductEvent);
   on<SearchProductByBrandEvent>(_handledSearchProductByBrandEvent);
  }


  FutureOr<void> _handledLoadProductEvent(
      LoadProductEvent event,
      Emitter<ProductState> emit) async
  {
    emit(ProductLoading());
    _localProductService.init();
    try{
      final products = await _productRepository.get();

      emit(ProductLoaded(products ?? []));

      if(products == null){
        final db = _localProductService.getProducts();
        emit(ProductLoaded(db));
      }
    }catch(e){
      emit(ErrorProductLoaded(e.toString()));
    }
  }



  FutureOr<void> _handledSearchCompleteProductEvent(
      SearchProduct event,
      Emitter<ProductState> emit) async {
      emit(SearchProductLoading());
      try{
        final products = await _productRepository.searchProduct(keyword: event.textInput);

        if(products.isNotEmpty){
          emit(SearchProductComplete(products));

        }else{
          emit(SearchProductError("Product not found!"));
        }

      }catch(e){
        emit(SearchProductError(e.toString()));
      }

  }

  FutureOr<void> _handledSearchProductByBrandEvent(
      SearchProductByBrandEvent event,
      Emitter<ProductState> emit) async
  {
    try{
      final products = await _productRepository.searchProductByBrand(id: event.id);

      if(products.isNotEmpty){
        emit(SearchProductComplete(products));

      }else{
        emit(SearchProductError("Product not found!"));
      }

    }catch(e){
      emit(SearchProductError(e.toString()));
    }
  }
}