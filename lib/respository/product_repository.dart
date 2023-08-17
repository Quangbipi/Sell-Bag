import 'dart:async';

import 'package:flutter_login/const.dart';
import 'package:flutter_login/models/product.dart';
import 'package:flutter_login/services/local_product_service.dart';
import 'package:http/http.dart' as http;
class ProductRepository {

  final remoteUrl = '$baseUrl/api/products';
  LocalProductService _localProductService = LocalProductService();
  Future<dynamic> get() async{
    try{
      final client = http.Client();
      await client.get(
          Uri.parse('$remoteUrl?populate=images,tags'))
      .timeout(Duration(seconds: 5))
      .then((response){
        if(response.statusCode == 200){
          print(response.body.toString());
          final products = productListFromJson(response.body);
          _localProductService.assigAllProducts(products: productListFromJson(response.body));
          return productListFromJson(response.body);
        }
      }).catchError((onError){

      }).whenComplete(() => client.close());
    }catch(e){

    }
  }

  Future<dynamic> searchProduct({required String keyword}) async{
    final client = http.Client();
    try {
      final response = await client.get(
        Uri.parse('$remoteUrl?populate=images,tags&filters[name][\$contains]=$keyword'),
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = productListFromJson(response.body);
        return data;
      } else {
        throw Exception('Request failed with status code ${response.statusCode}');
      }
    } finally {
    client.close();
    }
  }

  Future<dynamic> searchProductByBrand({required int id}) async{
    final client = http.Client();
    try {
      final response = await client.get(
        Uri.parse('$remoteUrl?populate=images,tags&filters[category][id]=$id'),
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = productListFromJson(response.body);
        return data;
      } else {
        throw Exception('Request failed with status code ${response.statusCode}');
      }
    } finally {
      client.close();
    }
  }
}