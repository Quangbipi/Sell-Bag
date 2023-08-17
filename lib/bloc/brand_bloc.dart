import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/sate/brand_state.dart';

import '../event/brand_event.dart';
import '../respository/brand_repository.dart';
import '../services/local_brand_service.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState>{
  final BrandRepository _brandRepository;
  final LocalBrandService _localBrandService = LocalBrandService();
  BrandBloc(this._brandRepository): super(BrandLoading()){
   on<LoadBrandEvent>(_handeldBrandLoaded);
  }


  FutureOr<void> _handeldBrandLoaded(
      LoadBrandEvent event,
      Emitter<BrandState> emit) async
  {
    emit(BrandLoading());
    try{
      final brandsList = await _brandRepository.getBrands();
      emit(BrandLoaded(brandsList ?? []));
      if(brandsList == null){
        var db = _localBrandService.getBrand();
        emit(BrandLoaded(db));
      }
    }catch(e){

    }
  }
}