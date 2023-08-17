import 'package:equatable/equatable.dart';

abstract class TabState extends Equatable{

  late final int index;
}

class TabInitial extends TabState{
  int index;

  TabInitial({required this.index});
  @override
  // TODO: implement props
  List<Object?> get props => [index];

}