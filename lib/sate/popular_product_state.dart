import 'package:equatable/equatable.dart';
import 'package:flutter_login/models/product.dart';

import '../models/category.dart';

abstract class PopularProductState extends Equatable{

}

class PopularProductLoading extends PopularProductState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class PopularProductLoaded extends PopularProductState{
  List<Product> productList;
  PopularProductLoaded(this.productList);

  @override
  // TODO: implement props
  List<Object?> get props => [productList];
}

class ErrorPopularProductLoaded extends PopularProductState{
  String error;
  ErrorPopularProductLoaded(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];}