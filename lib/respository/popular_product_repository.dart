import 'package:flutter_login/models/product.dart';
import 'package:flutter_login/services/local_popular_product_service.dart';
import 'package:flutter_login/services/local_product_service.dart';

import '../const.dart';
import 'package:http/http.dart' as http;
class PopularProductRepository {
  var remoteUrl = '$baseUrl/api/popular-products';
  final LocalPopularProductService _localPopularProductService = LocalPopularProductService();
  Future<dynamic> getProduct() async {

    try{
      final client = http.Client();
      await client.get(
          Uri.parse('$remoteUrl?populate=product,product.images'))
          .timeout(const Duration(seconds: 5))
          .then((response) {
          if(response.statusCode ==200){
            _localPopularProductService.assigAllPopularProducts(products: productList(response.body));
            return productList(response.body);
          }else{
            throw Exception("Lỗi");
          }
      }).catchError((onError){
        print("Lỗi: $onError");
      }).whenComplete(() => client.close());
    }catch(e){

    }


  }
}