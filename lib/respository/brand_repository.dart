import 'package:flutter_login/services/local_brand_service.dart';

import '../const.dart';
import 'package:http/http.dart' as http;

import '../models/category.dart';
class BrandRepository{
  var remoteUrl = '$baseUrl/api/categories';
  final LocalBrandService _localBrandService = LocalBrandService();
  Future<dynamic> getBrands() async {
    try{
      final client = http.Client();
      var responseBody;
      await client.get(
          Uri.parse('$remoteUrl?populate=image')
      ).timeout(const Duration(seconds: 5))
          .then((response) async {
        if(response.statusCode == 200){
          _localBrandService.assignAllBrands(brands: brandList(response.body));
          responseBody = response.body;
          //return categoryList(response.body);
        }else{
          throw Exception(response.statusCode);
        }
      }).catchError((error){
        print("Lỗi: $error");
      }).whenComplete((){
        client.close();
      });

      return brandList(responseBody);
    }catch(e){

    }

  }
}