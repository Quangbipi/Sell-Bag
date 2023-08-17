import 'package:equatable/equatable.dart';

abstract class BannerEvent extends Equatable{

}

class LoadBannerEvent extends BannerEvent{

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class LoadingBannerEvent extends BannerEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}