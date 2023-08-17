

import 'package:hive/hive.dart';

import '../models/ad_banner.dart';

class LocalAdBannerService{
  late Box<AdBanner> _adBannerbox;

  LocalAdBannerService(){
    init();
  }
  Future<void> init() async{
    _adBannerbox = await Hive.openBox<AdBanner>('AdBanners');

  }

  Future<void> assignAllAdBanners({required List<AdBanner> adBanners}) async{
    await _adBannerbox.clear();

    await _adBannerbox.addAll(adBanners);
  }

  List<AdBanner> getAdBanners() => _adBannerbox.values.toList();
}