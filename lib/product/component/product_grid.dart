import 'package:flutter/material.dart';

import 'package:flutter_login/product/component/product_card.dart';

import '../../models/product.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  const ProductGrid({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2/3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10
        ),
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(10),
        itemCount: products.length,
        itemBuilder: (context, indext) => ProductCard(product: products[indext],));
  }
}
