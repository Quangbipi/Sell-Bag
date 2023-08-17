import 'package:equatable/equatable.dart';

abstract class TabEvent extends Equatable{

}

class TabChange extends TabEvent{
  int indextInput;

  TabChange({required this.indextInput});

  @override
  // TODO: implement props
  List<Object?> get props => [indextInput];


}