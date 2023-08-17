import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PopularCategoryLoadingCard extends StatelessWidget {
  const PopularCategoryLoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Material(
          elevation: 8,
          shadowColor: Colors.grey.shade300,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Container(
              width: 270,
              height: 140,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)

              ),

            ),

          ),
        ),

    );

  }
}
