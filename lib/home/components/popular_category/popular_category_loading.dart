import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/category_bloc.dart';
import 'package:flutter_login/home/components/popular_category/popular_category_loading_card.dart';
import 'package:flutter_login/sate/category_state.dart';


class PopularCategoryLoading extends StatelessWidget {
  const PopularCategoryLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state){
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index){
              return PopularCategoryLoadingCard();
            });
      }),
    );
  }
}
