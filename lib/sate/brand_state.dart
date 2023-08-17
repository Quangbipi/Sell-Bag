import 'package:equatable/equatable.dart';

import '../models/category.dart';

abstract class BrandState extends Equatable{

}

class BrandLoading extends BrandState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class BrandLoaded extends BrandState{
  List<Category> categoryList;
  BrandLoaded(this.categoryList);

  @override
  // TODO: implement props
  List<Object?> get props => [categoryList];
}

class ErrorBrandLoaded extends BrandState{
  String error;
  ErrorBrandLoaded(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];}