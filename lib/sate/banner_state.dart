
import 'package:equatable/equatable.dart';

import '../models/ad_banner.dart';

abstract class BannerState extends Equatable{}

class BannerLoading extends BannerState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class BannerLoaded extends BannerState{

  List<AdBanner> bannerList;
  BannerLoaded(this.bannerList);
  @override
  // TODO: implement props
  List<Object?> get props => [bannerList];

}

class ErrorLoadingBanner extends BannerState{
  String errorMess;

  ErrorLoadingBanner(this.errorMess);
  @override
  // TODO: implement props
  List<Object?> get props => [errorMess];

}
