import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/const.dart';
import 'package:flutter_login/models/category.dart';
import 'package:shimmer/shimmer.dart';

import '../../../bloc/product_bloc.dart';
import '../../../bloc/tab_bloc.dart';
import '../../../event/product_event.dart';
import '../../../event/tab_event.dart';

class PoppularCategoryCard extends StatelessWidget {
  Category category;
  PoppularCategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        isSearching = true;
        context.read<TabBloc>().add(TabChange(indextInput: 1));
        context.read<ProductBloc>().add(SearchProductByBrandEvent(category.id));
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: CachedNetworkImage(
          imageUrl: '$baseUrl${category.image}',
          imageBuilder: (context, imageProvider)=> Material(
            elevation: 8,
            shadowColor: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 270,
              height: 140,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.contain,

                  )

              ),
              // child: Padding(
              //   padding: EdgeInsets.all(5),
              //   child: Text(
              //     product.name,
              //     style: const TextStyle(
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.black
              //     ),
              //   ),
              // ),
            ),
          ),
          placeholder: (context, url) => Material(
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
          errorWidget: (context, url, error) => Material(
            elevation: 8,
            shadowColor: Colors.grey.shade300,
            child:  Container(
              width: 270,
              height: 140,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)

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
      ),
    );
  }
}
