import 'package:equatable/equatable.dart';

import '../models/category.dart';

abstract class CategoryState extends Equatable{

}

class CategoryLoading extends CategoryState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class CategoryLoaded extends CategoryState{
  List<Category> categoryList;
  CategoryLoaded(this.categoryList);

  @override
  // TODO: implement props
  List<Object?> get props => [categoryList];
}

class ErrorCategoryLoaded extends CategoryState{
  String error;
  ErrorCategoryLoaded(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];}