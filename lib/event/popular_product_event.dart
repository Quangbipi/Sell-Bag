import 'package:equatable/equatable.dart';
import 'package:flutter_login/models/product.dart';

abstract class PopularProductEvent extends Equatable{

}

class LoadPopularProductEvent extends PopularProductEvent{
  @override

  List<Object?> get props => [];

}