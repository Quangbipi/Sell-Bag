import 'dart:convert';

import 'package:flutter_login/models/cart.dart';
import 'package:flutter_login/models/category.dart';
import 'package:flutter_login/models/product.dart';

import '../const.dart';
import 'package:http/http.dart' as http;

class CartRepository {
  var remoteUrl = '$baseUrl/api/carts';
  final client = http.Client();

  Future<dynamic> getCart({required int userId}) async {
    var response = await client.get(Uri.parse(
        '$remoteUrl?populate=product,product.images,product.tags&filters[userId][\$eq]=$userId'));

    if (response.statusCode == 200) {
      return cartList(response.body);
    } else {
      print("Lỗi");
    }
  }

  Future<dynamic> addToCart({
    required int userId,
    required int productId,
    required int productNumber,
  }) async {
    var body = {
      "data": {
        "userId": userId,
        "productId": productId,
        "productNumber": productNumber,
        "product": productId,
      }
    };

    var response = await client.post(Uri.parse(remoteUrl),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));

    if (response.statusCode == 200) {
      return response;
    } else {
      print("Lỗi");
    }
  }

  Future<dynamic> ChangeCartStatus(
      {required String status, required int id}) async {
    var body = {
      "data": {"cartStatus": status}
    };
    var response = await client.put(Uri.parse('$baseUrl/api/carts/$id'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body));

    if(response.statusCode == 200){
      return response;
    }else{
      print("lỗi");
    }
  }
}
