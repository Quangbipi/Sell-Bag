import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductLoadingCard extends StatelessWidget {
  const ProductLoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      shadowColor: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Column(
              children: [
                Flexible(
                  flex: 5,
                    child: Center(
                      child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.grey.shade300,

                  ),
                )),
                Flexible(
                  flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          height: 20,
                          color: Colors.grey.shade300,

                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 15,
                          width: 75,
                          color: Colors.grey.shade300,
                        )
                      ],
                ))
              ],
            )),
      )
    );
  }
}
