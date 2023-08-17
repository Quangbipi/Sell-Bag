import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/category_bloc.dart';
import 'package:flutter_login/sate/category_state.dart';

import 'popular_product_loading_card.dart';

class PopularProductLoadingView extends StatelessWidget {
  const PopularProductLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state){
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index){
              return PopularProductLoadingCard();
            });
      }),
    );
  }
}
