import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/const.dart';
import 'package:flutter_login/models/product.dart';
import 'package:flutter_login/product_detail/product_detail_screen.dart';
import 'package:shimmer/shimmer.dart';



class PopularProductCard extends StatelessWidget {
  Product product;
  PopularProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        // FocusScope.of(context).requestFocus(FocusNode());
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context)=> ProductDetailScreen(product: product)));
      },
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Material(
            elevation: 8,
            shadowColor: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              margin: const EdgeInsets.all(10),
              width: 120,
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 0.9,
                    child: CachedNetworkImage(
                      imageUrl: baseUrl + product.image.first,
                      placeholder: (context, url) => Material(
                          elevation: 8,
                          shadowColor: Colors.grey.shade300,
                          child: Shimmer.fromColors(
                              baseColor: Colors.grey,
                              highlightColor: Colors.white,
                              child: Container(
                                color: Colors.grey,
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.symmetric(horizontal: 25),

                              ))
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(width: 20,),
                  Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10, top: 20),
                      child: Container(
                        height: 15,
                        child: Text(
                          product.name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                          maxLines: 1,
                        ),
                      )
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
