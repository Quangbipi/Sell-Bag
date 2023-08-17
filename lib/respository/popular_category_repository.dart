
import 'package:flutter_login/models/category.dart';
import 'package:flutter_login/services/local_brand_service.dart';

import '../const.dart';
import 'package:http/http.dart' as http;
class PopularCategoryRepository {
  var remoteUrl = '$baseUrl/api/popular-categories';
  final LocalBrandService _localBrandService = LocalBrandService();
  Future<dynamic> getCategory() async {
    try{
      final client = http.Client();
      var responseBody;
      await client.get(
          Uri.parse('$remoteUrl?populate=category,category.image&pagination[start]=0&pagination[limit]=5')
      ).timeout(const Duration(seconds: 5))
          .then((response) async {
        if(response.statusCode == 200){
          _localBrandService.assignAllAdBrands(brands: categoryList(response.body));
          responseBody = response.body;
          //return categoryList(response.body);
        }else{
          throw Exception("lỗi");
        }
      }).catchError((error){
        print("Lỗi: $error");
      }).whenComplete((){
        client.close();
      });

      return categoryList(responseBody);
    }catch(e){

    }

  }
}