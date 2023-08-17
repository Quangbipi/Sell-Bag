import 'package:equatable/equatable.dart';

class SearchState extends Equatable{
  final String input;
  SearchState({required this.input});
  @override
  // TODO: implement props
  List<Object?> get props => [input];

  SearchState copyWith({
    String? input
  }){
    return SearchState(input: input ?? this.input);
  }
}
