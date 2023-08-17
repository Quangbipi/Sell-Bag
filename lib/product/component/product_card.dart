import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/models/product.dart';
import 'package:shimmer/shimmer.dart';

import '../../const.dart';
import '../../product_detail/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key,required this.product}) : super(key: key);

  Object price (){
    if (product.tags.isNotEmpty && product.tags.first.price != null) {
      return product.tags.first.price;
    } else {
      return 0.0;
    }
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=> ProductDetailScreen(product: product)));
      },
      child: Material(
        elevation: 8,
        shadowColor: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 5,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Hero(
                      tag: product.image.first,
                      child: CachedNetworkImage(
                        imageUrl: baseUrl + product.image.first,
                        placeholder: (context, url) =>  Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.white,
                          child: Center(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.grey.shade300,

                            ),
                          ),
                        ),
                        errorWidget: (context, url, erro) => Center(
                          child: Icon(
                            Icons.error_outline,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 10,),
            Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 5,),
                      Text("\$${price().toString()}",
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.black
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        )
      ),
    );
  }
}
