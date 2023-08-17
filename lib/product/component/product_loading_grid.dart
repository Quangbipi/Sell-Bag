import 'package:flutter/cupertino.dart';

import 'package:flutter_login/product/component/product_loading_card.dart';

class ProductLoadingGrid extends StatelessWidget {
  const ProductLoadingGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2/3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
        ),
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(10),
        itemCount: 6,
        itemBuilder: (context, indext) => ProductLoadingCard());
  }
}