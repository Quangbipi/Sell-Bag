import 'package:equatable/equatable.dart';

abstract class ProductSearchEvent extends Equatable{

}

class SearchCompleteEvent extends ProductSearchEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}