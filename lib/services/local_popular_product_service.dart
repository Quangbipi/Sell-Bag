

import 'package:flutter_login/models/product.dart';
import 'package:hive/hive.dart';

class LocalPopularProductService{
  late Box<Product> _popularProductBox;

  LocalPopularProductService(){
    init();
  }
  Future<void> init() async {
    _popularProductBox = await Hive.openBox<Product>('PopularProducts');
  }

  Future<void> assigAllPopularProducts({required List<Product> products}) async{
    await _popularProductBox.clear();
    await _popularProductBox.addAll(products);
  }

  List<Product> getPopularProducts() => _popularProductBox.values.toList();
}