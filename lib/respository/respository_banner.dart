import 'dart:convert';

import 'package:flutter_login/const.dart';
import 'package:flutter_login/services/local_ad_banner_service.dart';
import 'package:flutter_login/models/ad_banner.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;


class BannerRepository{
  var remoteUrl = '$baseUrl/api/banners';
  final LocalAdBannerService _localAdBannerService = LocalAdBannerService();
  Future<dynamic> getBanner() async {

    try{
      final client = http.Client();
      await client.get(
          Uri.parse('$remoteUrl?populate=image'))
          .timeout(Duration(seconds: 5))
          .then((response) async {
        print("quang log ${response}");
        if(response.statusCode ==200){
          _localAdBannerService.assignAllAdBanners(adBanners: adBannerListFromJson(response.body));
          return adBannerListFromJson(response.body);
        }else{
          throw Exception("Lỗi");
        }
      }).catchError((error) {
        print("Lỗi: $error");
      }).whenComplete(() {

        client.close();
      });

    }catch(e){

    }



  }



}