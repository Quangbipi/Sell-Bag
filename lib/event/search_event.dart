import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable{


}

class SearchInputChange extends SearchEvent{
  final String inputString;
  SearchInputChange(this.inputString);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}