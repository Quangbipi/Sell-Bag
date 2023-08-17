import 'package:equatable/equatable.dart';
import 'package:flutter_login/models/product.dart';

import '../models/category.dart';

abstract class ProductState extends Equatable{

}

class ProductLoading extends ProductState{


  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class ProductLoaded extends ProductState{
  List<Product> productList;

  ProductLoaded(this.productList);

  @override
  // TODO: implement props
  List<Object?> get props => [productList];
}

class ErrorProductLoaded extends ProductState{
  String error;
  ErrorProductLoaded(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class SearchProductLoading extends ProductState{

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class SearchProductComplete extends ProductState{
  final List<Product> products;

  SearchProductComplete(this.products);
  @override
  // TODO: implement props
  List<Object?> get props =>[products];

}

class SearchProductError extends ProductState{
  String error;
  SearchProductError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];

}