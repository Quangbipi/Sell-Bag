import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PopularProductLoadingCard extends StatelessWidget {
  const PopularProductLoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(10),
          shadowColor: Colors.grey.shade300,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Container(
              width: 120,
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 0.9,
                    child: Container(
                      color: Colors.grey,
                    ),

                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 15,
                    color: Colors.grey,

                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
