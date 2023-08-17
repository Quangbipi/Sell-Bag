import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/category_bloc.dart';
import 'package:flutter_login/home/components/popular_category/popular_category_card.dart';
import 'package:flutter_login/models/category.dart';
import 'package:flutter_login/sate/category_state.dart';

class PopularCategory extends StatelessWidget {
  List<Category> categories;
  PopularCategory({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state){
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index){

              return PoppularCategoryCard(category: categories[index],);
            });
      }),
    );
  }
}
