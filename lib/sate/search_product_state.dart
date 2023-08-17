import 'package:equatable/equatable.dart';
import 'package:flutter_login/models/product.dart';

abstract class SearchProductState extends Equatable{

}

class SearchProductLoading extends SearchProductState{
  final String productName;
  SearchProductLoading(this.productName);
  @override
  // TODO: implement props
  List<Object?> get props => [productName];

}

class SearchProductComplete extends SearchProductState{
  final List<Product> products;
  SearchProductComplete(this.products);
  @override
  // TODO: implement props
  List<Object?> get props =>[products];

}

class SearchProductError extends SearchProductState{
  String error;
  SearchProductError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];

}