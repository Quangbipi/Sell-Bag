import 'package:equatable/equatable.dart';
import 'package:flutter_login/models/product.dart';

abstract class ProductEvent extends Equatable{

}

class LoadProductEvent extends ProductEvent{
  @override

  List<Object?> get props => [];

}
class SearchProduct extends ProductEvent{
  final String textInput;
  SearchProduct(this.textInput);

  @override
  // TODO: implement props
  List<Object?> get props => [textInput];
}
class SearchProductByBrandEvent extends ProductEvent{
  final int id;
  SearchProductByBrandEvent(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [];

}