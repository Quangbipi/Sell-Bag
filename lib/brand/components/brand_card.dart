import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/product_bloc.dart';
import 'package:flutter_login/const.dart';
import 'package:flutter_login/event/product_event.dart';
import 'package:flutter_login/models/category.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/tab_bloc.dart';
import '../../event/tab_event.dart';

class BrandCard extends StatefulWidget {
  final Category category;
  const BrandCard({Key? key, required this.category}) : super(key: key);

  @override
  State<BrandCard> createState() => _BrandCardState();
}

class _BrandCardState extends State<BrandCard> {
  bool selected = false;
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          setState(() {
            selected = !selected;
          });

        },
        child: CachedNetworkImage(
            imageUrl: baseUrl + widget.category.image,
            imageBuilder: (context, imageProvider) => Material(
              elevation: 8,
              shadowColor: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12)
                ),
                padding: EdgeInsets.all(10),
                child:  AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  height: selected ? 200 : 140 ,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Align(
                      alignment: Alignment(1, 1),
                      child: InkWell(
                        onTap: (){
                          isSearching = true;
                          context.read<TabBloc>().add(TabChange(indextInput: 1));
                          context.read<ProductBloc>().add(SearchProductByBrandEvent(widget.category.id));

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.all(Radius.circular(24)),),
                          child:  Padding(
                            padding:const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8
                            ),
                            child: Text(
                              'View more',
                              style: TextStyle(
                                color: Colors.grey.shade500,

                              ),
                            ),
                          ),),
                      ),
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
                ),
                ),
              ),
            placeholder: (context, url) => Material(
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
                                  color: Colors.grey.shade500,
                                    fontWeight: FontWeight.bold

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
            errorWidget: (context, url, error) => Material(
              elevation: 8,
              shadowColor: Colors.grey.shade300,
              child: Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Center(
                  child: Icon(
                    Icons.error_outline,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            ),
        )
    );

  }
}
