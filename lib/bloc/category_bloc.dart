import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/event/category_event.dart';
import 'package:flutter_login/respository/popular_category_repository.dart';
import 'package:flutter_login/services/local_brand_service.dart';

import '../sate/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState>{

  final PopularCategoryRepository _popularCategoryRepository;
  final LocalBrandService _localBrandService = LocalBrandService();
  CategoryBloc(this._popularCategoryRepository) : super(CategoryLoading()){
    on<LoadCategoryEvent>(_handlerLoadCategoryEvent);
  }

  FutureOr<void> _handlerLoadCategoryEvent(
      LoadCategoryEvent event,
      Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    await _localBrandService.init();
    try{
      final categoryList = await _popularCategoryRepository.getCategory();
      emit(CategoryLoaded(categoryList ?? []));
      if(categoryList == null){
        var db = _localBrandService.getCategory();

        emit(CategoryLoaded(db));
      }

    }catch(e){
      emit(ErrorCategoryLoaded(e.toString()));
    }
  }
}