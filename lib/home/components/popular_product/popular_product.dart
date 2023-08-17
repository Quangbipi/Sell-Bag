

import 'package:flutter/material.dart';
import 'package:flutter_login/home/components/popular_product/popular_product_card.dart';
import 'package:flutter_login/models/product.dart';

class PopularProduct extends StatelessWidget {
  List<Product> productList;
 PopularProduct({Key? key, required this.productList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productList.length,
          itemBuilder: (context, index) => PopularProductCard(product: productList[index])
      ),
    );
  }
}
