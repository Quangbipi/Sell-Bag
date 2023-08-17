import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/const.dart';
import 'package:flutter_login/models/product.dart';
import 'package:shimmer/shimmer.dart';

class PopularProductCard extends StatelessWidget {
  Product product;
  PopularProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Material(
          elevation: 8,
          shadowColor: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: EdgeInsets.all(10),
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
                          child: Container(
                            color: Colors.grey,
                            padding: EdgeInsets.all(15),
                            margin: EdgeInsets.symmetric(horizontal: 25),

                          ),
                          baseColor: Colors.grey,
                          highlightColor: Colors.white)
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                // SizedBox(width: 20,),
                Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 10, top: 20),
                    child: Container(
                      height: 15,
                      child: Text(
                        product.name,
                        style: TextStyle(
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
    );
  }
}
