import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/event/banner_event.dart';
import 'package:flutter_login/services/local_ad_banner_service.dart';
import 'package:flutter_login/models/ad_banner.dart';
import 'package:flutter_login/sate/banner_state.dart';

import '../respository/respository_banner.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState>{

  final LocalAdBannerService _localAdBannerService = LocalAdBannerService();
  final BannerRepository _bannerRepository;
  BannerBloc(this._bannerRepository): super(BannerLoading()){
    on<LoadingBannerEvent>(_handlerLoadingBannerEvent);
    on<LoadBannerEvent>(_handlerLoadBannerEvent);
  }
  FutureOr<void> _handlerLoadBannerEvent(
      LoadBannerEvent event,
      Emitter<BannerState> emit) async {

    emit(BannerLoading());
    await _localAdBannerService.init();
    try{

      final adBannerList = await _bannerRepository.getBanner();
      emit(BannerLoaded(adBannerList ?? []));
      if(adBannerList == null){
        var ad = _localAdBannerService.getAdBanners();
        if(ad !=null) {

          emit(BannerLoaded(ad));
        }
      }

    }catch(e){
      emit(ErrorLoadingBanner(e.toString()));
    }
  }

  FutureOr<void> _handlerLoadingBannerEvent(
      LoadingBannerEvent event,
      Emitter<BannerState> emit ) async {
    //_bannerRepository.init();

  }
}