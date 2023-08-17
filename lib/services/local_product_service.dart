

import 'package:flutter_login/models/product.dart';
import 'package:hive/hive.dart';

class LocalProductService{
  late Box<Product> _productBox;

  LocalProductService(){
    init();
  }
  Future<void> init() async {
    _productBox = await Hive.openBox<Product>('Products');
  }

  Future<void> assigAllProducts({required List<Product> products}) async{
    await _productBox.clear();
    await _productBox.addAll(products);
  }

  List<Product> getProducts() => _productBox.values.toList();
}