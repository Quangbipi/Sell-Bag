import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../const.dart';

class ProductCarouselCard extends StatelessWidget {
  final String image;
  const ProductCarouselCard({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Hero(
        tag: image,
        child: CachedNetworkImage(
          imageUrl: baseUrl + image,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: AspectRatio(
                      aspectRatio: 1.5,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      ),

    );
  }
}
