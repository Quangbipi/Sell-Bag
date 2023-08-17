import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BrandLoadingCard extends StatelessWidget {
  const BrandLoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
          elevation: 8,
          shadowColor: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
          child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              child: Container(
                width: double.infinity,
                height: 140 ,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Align(
                    alignment: Alignment(1, 1),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.all(Radius.circular(24)),),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8
                        ),
                        child: Text(
                          'View more',
                          style: TextStyle(
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),),
                  ),
                  // child: Row(
                  //   mainAxisAlignment: MainAxisAlignment,
                  //   children: [
                  //     // Align(
                  //     //   alignment: const Alignment(-1, -1),
                  //     //   child: Text(
                  //     //     category.name,
                  //     //     style: const TextStyle(
                  //     //       fontSize: 20,
                  //     //       color: Colors.black,
                  //     //       fontWeight: FontWeight.bold
                  //     //     ),
                  //     //   ),
                  //     // ),
                  //
                  //   ],
                  // ),
                ),
              ))
      ),
    );
  }
}
